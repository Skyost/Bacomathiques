import path from 'path'
import fs from 'fs'
import * as yaml from 'yaml'
import { consola } from 'consola'
import {
  type ApiComment,
  apiDirectory,
  type ApiLesson,
  formatHtml,
  lessonCommentsEndpoint,
  lessonContentEndpoint,
  lessonListEndpoint,
  lessonListEndpointItem,
  lessonSummaryEndpoint,
  moduleName
} from './common'
import { getAvatarUrl, site } from '../../app/site/site'
import type { Comment } from '../../app/types'

/**
 * The logger instance.
 */
const logger = consola.withTag(moduleName)

export function generateLessonApiFiles(content: Record<string, unknown>, rootDir: string) {
  const contentDirectoryPath = path.resolve(rootDir, 'content')

  // We create the lesson.
  const lesson: ApiLesson = {
    ...content,
    id: content.slug,
    html: content.body,
    summary: content.summary,
    comments: []
  } as ApiLesson
  lesson.html = formatHtml(lesson, lesson.html)
  lesson.summary = formatHtml(lesson, lesson.summary)

  // We add the comments to the current lesson.
  const commentsDirectoryPath = path.resolve(contentDirectoryPath, 'comments')
  const comments = fs.existsSync(commentsDirectoryPath) ? fs.readdirSync(commentsDirectoryPath) : []
  for (const file of comments) {
    const comment: Comment = yaml.parse(fs.readFileSync(path.resolve(commentsDirectoryPath, file)).toString())
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
  const levelDirectoryPath = path.resolve(rootDir, apiDirectory, lesson.level)
  const lessonDirectoryPath = path.resolve(levelDirectoryPath, lesson.id)
  logger.info(`Generating API files for ${lesson.level}/${lesson.id}...`)
  fs.mkdirSync(lessonDirectoryPath, { recursive: true })
  fs.writeFileSync(path.resolve(lessonDirectoryPath, 'index.json'), JSON.stringify(lessonContentEndpoint(lesson)))

  const lessonSummaryDirectory = path.resolve(lessonDirectoryPath, 'summary')
  fs.mkdirSync(lessonSummaryDirectory, { recursive: true })
  fs.writeFileSync(path.resolve(lessonSummaryDirectory, 'index.json'), JSON.stringify(lessonSummaryEndpoint(lesson)))

  const lessonCommentsDirectory = path.resolve(lessonDirectoryPath, 'comments')
  fs.mkdirSync(lessonCommentsDirectory, { recursive: true })
  fs.writeFileSync(path.resolve(lessonCommentsDirectory, 'index.json'), JSON.stringify(lessonCommentsEndpoint(lesson)))
  logger.success(`Generated API files for ${lesson.level}/${lesson.id}.`)

  // Update the lesson index.
  const levelDataFilePath = path.resolve(levelDirectoryPath, 'index.json')
  let levelData: ReturnType<typeof lessonListEndpoint>
  if (fs.existsSync(levelDataFilePath)) {
    levelData = JSON.parse(fs.readFileSync(levelDataFilePath, { encoding: 'utf8' }))
    const duplicate = levelData.list.findIndex(addedLesson => addedLesson.lesson.chapter === lesson.chapter)
    if (duplicate !== -1) {
      levelData.list.splice(duplicate, 1)
    }
    levelData.list.push(lessonListEndpointItem(lesson))
    levelData.list.sort((a, b) => a.lesson.chapter - b.lesson.chapter)
  }
  else {
    levelData = lessonListEndpoint([lesson])
  }
  fs.writeFileSync(levelDataFilePath, JSON.stringify(levelData))
}
