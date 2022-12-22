// This is just a temporary module that will allow users to upgrade to the new API (which is not ready at all to be honest).

import fs from 'fs'
import { parse } from 'node-html-parser'
import yaml from 'yaml'
import mkdirp from 'mkdirp'
import { createResolver, defineNuxtModule } from '@nuxt/kit'
import * as matter from 'gray-matter'
import site from '../site'
import { levels as levelsData, getAvatarURL, getPdfUrl } from '../utils/lesson'
import logger from '../utils/logger'

const name = 'generate-api-v2'
const api = {
  version: 2,
  latestVersion: 2
}

export default defineNuxtModule({
  meta: {
    name,
    version: '0.0.1',
    compatibility: { nuxt: '^3.0.0-rc.10' }
  },
  setup: (_, nuxt) => {
    const resolver = createResolver(import.meta.url)
    const levels = Object.values(levelsData)
    const lessons = []

    for (const level of levels) {
      level.lessons = `/api/v2/${level.id}/`
      const lessonsDirectory = resolver.resolve(nuxt.options.srcDir, 'content', 'generated', 'lessons', level.id)
      const files = fs.readdirSync(lessonsDirectory)
      for (const file of files) {
        const { data: lesson, content: html } = matter.read(resolver.resolve(lessonsDirectory, file))
        const { content: summary } = matter.read(resolver.resolve(nuxt.options.srcDir, 'content', 'generated', 'summaries', lesson.level, `${lesson.id}.md`))
        lesson.html = formatHTML(resolver, nuxt.options.srcDir, lesson, html)
        lesson.summary = formatHTML(resolver, nuxt.options.srcDir, lesson, summary)
        lesson.comments = []
        lesson.e3c = []
        lessons.push(lesson)
      }
    }
    levels.sort((a, b) => a.order - b.order)
    lessons.sort((a, b) => a.chapter - b.chapter)

    const commentsDirectory = resolver.resolve(nuxt.options.srcDir, 'content', 'comments')
    const files = fs.readdirSync(commentsDirectory)
    for (const file of files) {
      const comment = yaml.parse(fs.readFileSync(resolver.resolve(commentsDirectory, file)).toString())
      getLessonById(lessons, comment.level, comment.lesson).comments.push({
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

    for (const lesson of lessons) {
      lesson.comments.sort((a, b) => b.date - a.date)
    }

    const apiDirectory = resolver.resolve(nuxt.options.srcDir, 'node_modules/.cache/.api-v2')
    mkdirp.sync(apiDirectory)
    fs.writeFileSync(resolver.resolve(apiDirectory, 'index.json'), JSON.stringify(mainEndpoint(levels)))

    for (const level of levels) {
      logger.info(name, `Generating API files for ${level.id}...`)
      const levelDirectory = resolver.resolve(apiDirectory, level.id)
      mkdirp.sync(levelDirectory)
      fs.writeFileSync(resolver.resolve(levelDirectory, 'index.json'), JSON.stringify(lessonListEndpoint(lessons, level)))

      const levelLessons = getLevelLessons(lessons, level)
      for (const lesson of levelLessons) {
        logger.info(name, `Generating API files for ${level.id}/${lesson.id}...`)
        const lessonDirectory = resolver.resolve(levelDirectory, lesson.id)
        mkdirp.sync(lessonDirectory)
        fs.writeFileSync(resolver.resolve(lessonDirectory, 'index.json'), JSON.stringify(lessonContentEndpoint(lesson)))

        const lessonSummaryDirectory = resolver.resolve(lessonDirectory, 'summary')
        mkdirp.sync(lessonSummaryDirectory)
        fs.writeFileSync(resolver.resolve(lessonSummaryDirectory, 'index.json'), JSON.stringify(lessonSummaryEndpoint(lesson)))

        const lessonCommentsDirectory = resolver.resolve(lessonDirectory, 'comments')
        mkdirp.sync(lessonCommentsDirectory)
        fs.writeFileSync(resolver.resolve(lessonCommentsDirectory, 'index.json'), JSON.stringify(lessonCommentsEndpoint(lesson)))
      }
    }

    nuxt.options.nitro.publicAssets = nuxt.options.nitro.publicAssets || []
    nuxt.options.nitro.publicAssets.push({
      baseURL: '/api/v2',
      dir: apiDirectory
    })
  }
})

function mainEndpoint (levels) {
  return {
    api,
    levels
  }
}

function lessonListEndpoint (lessons, level) {
  const levelLessons = getLevelLessons(lessons, level)
  const list = []
  for (const lesson of levelLessons) {
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
    difficulty: parseInt(lesson.difficulty),
    pdf: getPdfUrl(lesson),
    html: lesson.html,
    annals: [],
    e3c: []
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
    postCommentUrl: 'https://vercel.bacomathiqu.es/api/post-comment',
    // TODO: Remove below.
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

function getLessonInfo (lesson, isSummary = false) {
  const apiRoot = `/api/v2/${lesson.level}/${lesson.id}/`
  return {
    id: lesson.id,
    level: lesson.level,
    title: lesson.title + (isSummary ? ' - Fiche résumée' : ''),
    chapter: parseInt(lesson.chapter),
    specialty: !!lesson.specialty,
    content: apiRoot,
    comments: `${apiRoot}comments/`,
    summary: `${apiRoot}summary/`
  }
}

function getLevelLessons (lessons, level) {
  return lessons.filter(lesson => lesson.level === level.id)
}

function formatHTML (resolver, srcDir, lesson, html) {
  const root = parse(html)
  const displays = root.querySelectorAll('.katex-display')
  for (const display of displays) {
    display.replaceWith(`<div class="katex-display">${display.innerHTML}</div>`)
  }
  const maths = root.querySelectorAll('.math-rendered')
  for (const math of maths) {
    const latex = math.getAttribute('data-latex')
    if (latex) {
      const display = math.getAttribute('data-latex-display') === 'true'
      if (display) {
        math.replaceWith(`<math displaystyle>${latex}</math>`)
      } else {
        math.replaceWith(`<math>${latex}</math>`)
      }
    }
    // const annotation = math.querySelector('annotation[encoding="application/x-tex"]')
    // if (annotation) {
    //   const display = math.querySelector('math').attributes.display === 'block'
    //   if (display) {
    //     math.replaceWith(`<math displaystyle>${annotation.rawText.trim()}</math>`)
    //   } else {
    //     math.replaceWith(`<math>${annotation.rawText.trim()}</math>`)
    //   }
    // }
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
    if (!src) {
      continue
    }
    if (src.startsWith('/')) {
      image.setAttribute('src', site.host + src)
      src = src.substring(1)
    } else if (src.startsWith(site.host)) {
      src = src.substring(site.host.length)
    }
    const extension = src.substring(src.lastIndexOf('.'))
    const darkPath = src.substring(0, src.length - extension.length) + '-dark' + extension
    if (fs.existsSync(resolver.resolve(srcDir, 'static', darkPath))) {
      image.setAttribute('data-src-dark', site.host + '/' + darkPath)
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
    representation.replaceWith(`<div id="representation-${i + 1}" class="plot" data-api-v2-geogebra-id="${id}" data-api-v2-geogebra-image="${site.host}/img/lessons/${lesson.level}/${lesson.id}/${id}.png"></div>`)
  }
  const anchors = root.querySelectorAll('h2 a, h3 a')
  for (const anchor of anchors) {
    anchor.remove()
  }
  return root.toString()
}

function getLessonById (lessons, levelId, lessonId) {
  for (const lesson of lessons) {
    if (lesson.level === levelId && lesson.id === lessonId) {
      return lesson
    }
  }
  return null
}
