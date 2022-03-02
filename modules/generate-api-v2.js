// This is just a temporary module that will allow users to upgrade to the new API (which is not ready at all to be honest).

import { getAvatarURL } from '../utils/lesson'
import { HOST_NAME } from '../utils/site'

const { resolve } = require('path')
const fs = require('fs')
const { parse } = require('node-html-parser')
const yaml = require('yaml')
const mkdirp = require('mkdirp')
const logger = require('./logger')

const api = {
  version: 2,
  latestVersion: 2
}
const levels = []
const lessons = []

module.exports = function () {
  const {
    srcDir,
    rootDir,
    generate: { dir: generateDir }
  } = this.options

  this.nuxt.hook('build:compile', function ({ name }) {
    if (name !== 'server') {
      return
    }
    const levelsDirectory = resolve(srcDir, 'content', 'levels')
    let files = fs.readdirSync(levelsDirectory)
    for (const file of files) {
      const level = yaml.parse(fs.readFileSync(resolve(levelsDirectory, file)).toString())
      level.lessons = `/api/v2/${level.id}/`
      levels.push(level)
    }
    levels.sort((a, b) => a.order - b.order)

    for (const level of levels) {
      const lessonsDirectory = resolve(srcDir, 'content', 'lessons', level.id)
      files = fs.readdirSync(lessonsDirectory)
      for (const file of files) {
        const lesson = yaml.parse(fs.readFileSync(resolve(lessonsDirectory, file)).toString())
        lesson.html = getHTML(srcDir, lesson)
        lesson.summary = getHTML(srcDir, lesson, true)
        lesson.comments = []
        lesson.e3c = []
        lessons.push(lesson)
      }
    }
    lessons.sort((a, b) => a.chapter - b.chapter)

    const commentsDirectory = resolve(srcDir, 'content', 'comments')
    files = fs.readdirSync(commentsDirectory)
    for (const file of files) {
      const comment = yaml.parse(fs.readFileSync(resolve(commentsDirectory, file)).toString())
      getLessonById(comment.level, comment.lesson).comments.push({
        id: comment._id,
        author: {
          name: comment.author,
          avatar: getAvatarURL(comment.author),
          isModerator: comment.author === 'Skyost'
        },
        date: comment.date,
        message: comment.message
      })
    }

    const e3cDirectory = resolve(srcDir, 'content', 'e3c')
    files = fs.readdirSync(e3cDirectory)
    for (const file of files) {
      const e3c = yaml.parse(fs.readFileSync(resolve(e3cDirectory, file)).toString())
      const clone = Object.assign({}, e3c)
      delete clone.lessons
      for (const lesson of e3c.lessons) {
        getLessonById(lesson.level, lesson.lesson).e3c.push(clone)
      }
    }

    for (const lesson of lessons) {
      lesson.comments.sort((a, b) => b.date - a.date)
      lesson.e3c.sort((a, b) => a.id.localeCompare(b.id))
    }
  })

  this.nuxt.hook('generate:done', () => {
    const apiDirectory = resolve(rootDir, generateDir, 'api', 'v2')
    mkdirp.sync(apiDirectory)
    fs.writeFileSync(resolve(apiDirectory, 'index.json'), JSON.stringify(mainEndpoint()))

    for (const level of levels) {
      logger.info(`Generating API files for ${level.id}...`)
      const levelDirectory = resolve(apiDirectory, level.id)
      mkdirp.sync(levelDirectory)
      fs.writeFileSync(resolve(levelDirectory, 'index.json'), JSON.stringify(lessonListEndpoint(level)))

      const levelLessons = getLevelLessons(level)
      for (const lesson of levelLessons) {
        logger.info(`Generating API files for ${level.id}/${lesson.id}...`)
        const lessonDirectory = resolve(levelDirectory, lesson.id)
        mkdirp.sync(lessonDirectory)
        fs.writeFileSync(resolve(lessonDirectory, 'index.json'), JSON.stringify(lessonContentEndpoint(lesson)))

        const lessonSummaryDirectory = resolve(lessonDirectory, 'summary')
        mkdirp.sync(lessonSummaryDirectory)
        fs.writeFileSync(resolve(lessonSummaryDirectory, 'index.json'), JSON.stringify(lessonSummaryEndpoint(lesson)))

        const lessonCommentsDirectory = resolve(lessonDirectory, 'comments')
        mkdirp.sync(lessonCommentsDirectory)
        fs.writeFileSync(resolve(lessonCommentsDirectory, 'index.json'), JSON.stringify(lessonCommentsEndpoint(lesson)))
      }
    }
  })
}

function mainEndpoint () {
  return {
    api,
    levels
  }
}

function lessonListEndpoint (level) {
  const lessons = getLevelLessons(level)
  const list = []
  for (const lesson of lessons) {
    list.push({
      lesson: getLessonInfo(lesson),
      preview: `/img/lessons/${lesson.level}/${lesson.id}/preview.jpg`,
      caption: lesson.caption,
      excerpt: lesson.excerpt
    })
  }
  return {
    api,
    list
  }
}

function lessonContentEndpoint (lesson) {
  return {
    api,
    lesson: getLessonInfo(lesson),
    difficulty: lesson.difficulty,
    pdf: lesson.pdf,
    html: lesson.html,
    annals: [],
    e3c: lesson.e3c
  }
}

function lessonSummaryEndpoint (lesson) {
  return {
    api,
    lesson: getLessonInfo(lesson),
    html: lesson.summary
  }
}

function lessonCommentsEndpoint (lesson) {
  return {
    api,
    lesson: getLessonInfo(lesson),
    post: {
      url: 'https://postman.bacomathiqu.es/v3/entry/github/Skyost/Bacomathiques/master/comments',
      fields: [
        {
          name: 'slug',
          type: 'options'
        },
        {
          name: 'lesson',
          type: 'fields'
        },
        {
          name: 'level',
          type: 'fields'
        },
        {
          name: 'client',
          type: 'fields'
        },
        {
          name: 'message',
          type: 'fields'
        },
        {
          name: 'author',
          type: 'fields'
        }
      ]
    },
    list: lesson.comments
  }
}

function getLessonInfo (lesson, isSummary) {
  const apiRoot = `/api/v2/${lesson.level}/${lesson.id}/`
  return {
    id: lesson.id,
    level: lesson.level,
    title: lesson.title + (isSummary ? ' - Fiche résumée' : ''),
    chapter: lesson.chapter,
    specialty: lesson.specialty,
    content: apiRoot,
    comments: `${apiRoot}comments/`,
    summary: `${apiRoot}summary/`
  }
}

function getLevelLessons (level) {
  return lessons.filter(lesson => lesson.level === level.id)
}

function getHTML (srcDir, lesson, isSummary) {
  const lessonContent = resolve(srcDir, 'content', 'markdown', isSummary ? 'summaries' : 'lessons', lesson.level, `${lesson.id}.md`)
  const html = fs
    .readFileSync(lessonContent)
    .toString()
  return formatHTML(srcDir, lesson, html.toString())
}

function formatHTML (srcDir, lesson, html) {
  const root = parse(html)
  const displays = root.querySelectorAll('.katex-display')
  for (const display of displays) {
    display.replaceWith(`<div class="katex-display center">${display.innerHTML}</div>`)
  }
  const maths = root.querySelectorAll('.katex')
  for (const math of maths) {
    const annotation = math.querySelector('annotation[encoding="application/x-tex"]')
    if (annotation) {
      const display = math.querySelector('math').attributes.display === 'block'
      if (display) {
        math.replaceWith(`<math displaystyle>${annotation.rawText.trim()}</math>`)
      } else {
        math.replaceWith(`<math>${annotation.rawText.trim()}</math>`)
      }
    }
  }
  const bubbles = root.querySelectorAll('bubble')
  for (const bubble of bubbles) {
    let attributes = ''
    const contentWidth = bubble.getAttribute('content-width')
    if (contentWidth) {
      attributes += ` data-api-v2-content-width="${contentWidth}"`
    }
    const variant = bubble.getAttribute('variant')
    if (variant) {
      attributes += ` class="${variant}"`
    }
    bubble.replaceWith(`<div${attributes}>${bubble.innerHTML}</div>`)
  }
  const images = root.querySelectorAll('img')
  for (const image of images) {
    let src = image.getAttribute('src')
    if (src.startsWith('/')) {
      image.setAttribute('src', HOST_NAME + src)
      src = src.substring(1)
    } else if (src.startsWith(HOST_NAME)) {
      src = src.substring(HOST_NAME.length)
    }
    const extension = src.substring(src.lastIndexOf('.'))
    const darkPath = src.substring(0, src.length - extension.length) + '-dark' + extension
    if (fs.existsSync(resolve(srcDir, 'static', darkPath))) {
      image.setAttribute('data-src-dark', HOST_NAME + '/' + darkPath)
    }
  }
  const tables = root.querySelectorAll('table')
  for (const table of tables) {
    table.classList.add('table')
    table.classList.add('table-bordered')
    table.classList.add('table-hover')
  }
  const representations = root.querySelectorAll('representation')
  for (let i = 0; i < representations.length; i++) {
    const representation = representations[i]
    const id = representation.getAttribute('geogebra-id')
    representation.replaceWith(`<div id="representation-${i + 1}" class="plot" data-api-v2-geogebra-id="${id}" data-api-v2-geogebra-image="${HOST_NAME}/img/lessons/${lesson.level}/${lesson.id}/${id}.png"></div>`)
  }
  const anchors = root.querySelectorAll('h2 a, h3 a')
  for (const anchor of anchors) {
    anchor.remove()
  }
  return root.toString()
}

function getLessonById (levelId, lessonId) {
  for (const lesson of lessons) {
    if (lesson.level === levelId && lesson.id === lessonId) {
      return lesson
    }
  }
  return null
}
