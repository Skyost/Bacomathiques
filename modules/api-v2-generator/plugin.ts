import path from 'path'
import fs from 'fs'
import { createResolver } from '@nuxt/kit'
import * as yaml from 'yaml'
import {
  type ApiComment, apiDirectory,
  type ApiLesson, formatHtml,
  lessonCommentsEndpoint,
  lessonContentEndpoint,
  lessonListEndpoint, lessonListEndpointItem,
  lessonSummaryEndpoint,
  moduleName
} from '~/modules/api-v2-generator/common'
import * as logger from '~/utils/logger'
import { getAvatarUrl, site } from '~/site/site'
import type { Comment } from '~/types'

/**
 * Nitro plugin to generate API v2 files from parsed LaTeX files.
 */
export default defineNitroPlugin((nitroApp) => {
  // @ts-ignore
  nitroApp.hooks.hook('content:file:afterParse', (file) => {
    if (!file._id.endsWith('.tex')) {
      return
    }

    // Resolver for creating absolute paths.
    const resolver = createResolver(import.meta.url)

    // Absolute path to the source directory.
    const sourceDirectoryPath = path.resolve('./')
    const contentDirectoryPath = resolver.resolve(sourceDirectoryPath, 'content')

    // We create the lesson.
    const lesson: ApiLesson = {
      ...file,
      html: file.body,
      summary: file.summary,
      comments: []
    }
    lesson.html = formatHtml(resolver, contentDirectoryPath, lesson, lesson.html)
    lesson.summary = formatHtml(resolver, contentDirectoryPath, lesson, lesson.summary)

    // We add the comments to the current lesson.
    const commentsDirectoryPath = resolver.resolve(contentDirectoryPath, 'comments')
    const comments = fs.readdirSync(commentsDirectoryPath)
    for (const file of comments) {
      const comment: Comment = yaml.parse(fs.readFileSync(resolver.resolve(commentsDirectoryPath, file)).toString())
      if (comment.level !== lesson.level || comment.lesson !== lesson.id) {
        continue
      }
      const apiComment: ApiComment = {
        id: comment._id,
        author: {
          name: comment.author,
          avatar: getAvatarUrl(comment.author),
          isModerator: site.moderators.includes(comment.author)
        },
        date: comment.date,
        message: comment.message
      }
      lesson.comments.push(apiComment)
    }
    lesson.comments.sort((a, b) => b.date - a.date)

    // Generate the lesson data files.
    const levelDirectoryPath = resolver.resolve(sourceDirectoryPath, apiDirectory, file.level)
    const lessonDirectoryPath = resolver.resolve(levelDirectoryPath, file.id)
    logger.info(moduleName, `Generating API files for ${file.level}/${file.id}...`)
    fs.mkdirSync(lessonDirectoryPath, { recursive: true })
    fs.writeFileSync(resolver.resolve(lessonDirectoryPath, 'index.json'), JSON.stringify(lessonContentEndpoint(lesson)))

    const lessonSummaryDirectory = resolver.resolve(lessonDirectoryPath, 'summary')
    fs.mkdirSync(lessonSummaryDirectory, { recursive: true })
    fs.writeFileSync(resolver.resolve(lessonSummaryDirectory, 'index.json'), JSON.stringify(lessonSummaryEndpoint(lesson)))

    const lessonCommentsDirectory = resolver.resolve(lessonDirectoryPath, 'comments')
    fs.mkdirSync(lessonCommentsDirectory, { recursive: true })
    fs.writeFileSync(resolver.resolve(lessonCommentsDirectory, 'index.json'), JSON.stringify(lessonCommentsEndpoint(lesson)))
    logger.success(moduleName, `Generated API files for ${file.level}/${file.id}.`)

    // Update the lesson index.
    const levelDataFilePath = resolver.resolve(levelDirectoryPath, 'index.json')
    let levelData: ReturnType<typeof lessonListEndpoint>
    if (fs.existsSync(levelDataFilePath)) {
      levelData = JSON.parse(fs.readFileSync(levelDataFilePath, { encoding: 'utf8' }))
      const duplicate = levelData.list.findIndex(addedLesson => addedLesson.lesson.chapter === lesson.chapter)
      if (duplicate !== -1) {
        levelData.list = levelData.list.splice(duplicate, 1)
      }
      levelData.list.push(lessonListEndpointItem(lesson))
      levelData.list.sort((a, b) => a.lesson.chapter - b.lesson.chapter)
    } else {
      levelData = lessonListEndpoint([lesson])
    }
    fs.writeFileSync(levelDataFilePath, JSON.stringify(levelData))
  })
})
