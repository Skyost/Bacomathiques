// noinspection ES6PreferShortImport

import { parse } from 'node-html-parser'
import { site } from '../../site/site'
import type { Lesson, Level, LevelId } from '../../types'

/**
 * The module name.
 */
export const moduleName = 'api-v2-generator'
/**
 * The API directory. Will be added to Nitro.
 */
export const apiDirectory = 'node_modules/.api-v2'

/**
 * Represents a comment in the API.
 */
export interface ApiComment {
  /**
   * Unique identifier for the comment.
   */
  id: string

  /**
  * Information about the author of the comment.
  */
  author: {
    /**
     * Name of the comment author.
     */
    name: string

    /**
     * URL of the author's avatar.
     */
    avatar: string

    /**
     * Indicates whether the author is a moderator.
     */
    isModerator: boolean
  };

  /**
   * Timestamp representing the date of the comment.
   */
  date: number

  /**
   * Text content of the comment.
   */
  message: string
}

/**
 * Represents a level in the API, extends a generic 'Level' interface.
 */
export interface ApiLevel extends Level {
  /**
   * String representing lessons information for the level.
   */
  lessons: string
}

/**
 * Represents a lesson in the API, extends a generic 'Lesson' interface.
 */
export interface ApiLesson extends Lesson {
  /**
   * HTML content of the lesson.
   */
  html: string

  /**
   * Summary HTML content of the lesson.
   */
  summary: string

  /**
   * Array of comments associated with the lesson.
   */
  comments: ApiComment[]
}

/**
 * Represents the information for an API lesson.
 *
 * @interface
 */
interface ApiLessonInfo {
  /**
   * Unique identifier for the lesson.
   *
   * @type {string}
   */
  id: string;

  /**
   * Level identifier for the lesson.
   *
   * @type {LevelId}
   */
  level: LevelId;

  /**
   * Title of the lesson.
   *
   * @type {string}
   */
  title: string;

  /**
   * Chapter number of the lesson.
   *
   * @type {number}
   */
  chapter: number;

  /**
   * Indicates whether the lesson has a specialty.
   *
   * @type {boolean}
   */
  specialty: boolean;

  /**
   * Content API endpoint for the lesson.
   *
   * @type {string}
   */
  content: string;

  /**
   * Comments API endpoint for the lesson.
   *
   * @type {string}
   */
  comments: string;

  /**
   * Summary API endpoint for the lesson.
   *
   * @type {string}
   */
  summary: string;
}

/**
 * Represents an API configuration.
 */
interface Api {
  /**
   * API version number.
   */
  version: number,

  /**
   * Latest version of the API.
   */
  latestVersion: number
}

/**
 * Represents the current API configuration.
 */
const api: Api = { version: 2, latestVersion: 2 }

/**
 * Main API endpoint that returns API and levels.
 *
 * @param {ApiLevel[]} levels - Array of API levels.
 * @returns {{ api: Api, levels: ApiLevel[] }} - Object containing API and levels.
 */
export const mainEndpoint = (levels: ApiLevel[]): { api: Api; levels: ApiLevel[] } => {
  return { api, levels }
}

/**
 * Lesson list API endpoint that returns API, and a list of lessons.
 *
 * @param {ApiLesson[]} lessons - Array of API lessons (optional).
 * @returns {{ api: Api, list: ReturnType<typeof lessonListEndpointItem>[] }} - Object containing API and a list of lesson items.
 */
export const lessonListEndpoint = (lessons: ApiLesson[] = []): { api: Api; list: ReturnType<typeof lessonListEndpointItem>[] } => {
  return {
    api,
    list: lessons.map(lessonListEndpointItem)
  }
}

/**
 * Converts an API lesson to a list item format.
 *
 * @param {ApiLesson} lesson - API lesson object.
 * @returns {{ lesson: ApiLessonInfo, preview: string, caption: string, excerpt: string }} - Converted lesson list item.
 */
export const lessonListEndpointItem = (lesson: ApiLesson): { lesson: ApiLessonInfo, preview: string, caption: string, excerpt: string } => {
  return {
    lesson: getLessonInfo(lesson),
    preview: `/img/lessons/${lesson.level}/${lesson.id}/preview.jpg`,
    caption: lesson.caption,
    excerpt: lesson.description
  }
}

/**
 * Lesson content API endpoint that returns API and lesson content details.
 *
 * @param {ApiLesson} lesson - API lesson object.
 * @returns {{ api: Api, lesson: ApiLessonInfo, difficulty: number, pdf: string, html: string }} - Object containing API, lesson details, and content.
 */
export const lessonContentEndpoint = (lesson: ApiLesson): { api: Api; lesson: ApiLessonInfo; difficulty: number; pdf: string; html: string } => {
  return {
    api,
    lesson: getLessonInfo(lesson),
    difficulty: lesson.difficulty,
    pdf: lesson.pdf,
    html: lesson.html
  }
}

/**
 * Lesson summary API endpoint that returns API, lesson info, and HTML summary.
 *
 * @param {ApiLesson} lesson - API lesson object.
 * @returns {{ api: Api, lesson: ApiLessonInfo, html: string }} - Object containing API, lesson info, and HTML summary.
 */
export const lessonSummaryEndpoint = (lesson: ApiLesson): { api: Api; lesson: ApiLessonInfo; html: string } => {
  return {
    api,
    lesson: getLessonInfo(lesson),
    html: lesson.summary
  }
}

/**
 * Lesson comments API endpoint that returns API, lesson info, post comment URL, and a list of comments.
 *
 * @param {ApiLesson} lesson - API lesson object.
 * @returns {{ api: Api, lesson: ApiLessonInfo, postCommentUrl: string, list: ApiComment[] }} - Object containing API, lesson info, post comment URL, and a list of comments.
 */
export const lessonCommentsEndpoint = (lesson: ApiLesson): { api: Api; lesson: ApiLessonInfo; postCommentUrl: string; list: ApiComment[] } => {
  return {
    api,
    lesson: getLessonInfo(lesson),
    postCommentUrl: 'https://vercel.bacomathiqu.es/api/post-comment',
    list: lesson.comments
  }
}

/**
 * Gets lesson information for API purposes.
 *
 * @param {ApiLesson} lesson - API lesson object.
 * @param {boolean} [isSummary=false] - Indicates whether it's a summary.
 * @returns {ApiLessonInfo} - Object containing lesson information.
 */
export const getLessonInfo = (lesson: ApiLesson, isSummary: boolean = false): ApiLessonInfo => {
  const apiRoot = `/api/v2/${lesson.level}/${lesson.id}/`
  return {
    id: lesson.id,
    level: lesson.level,
    title: lesson.title + (isSummary ? ' - Fiche résumée' : ''),
    chapter: lesson.chapter,
    specialty: lesson.specialty === true,
    content: apiRoot,
    comments: `${apiRoot}comments/`,
    summary: `${apiRoot}summary/`
  }
}

/**
 * Formats HTML content by modifying certain elements.
 *
 * @param {ApiLesson} lesson - API lesson object.
 * @param {string} html - HTML content to be formatted.
 * @returns {string} - Formatted HTML content.
 */
export const formatHtml = (lesson: ApiLesson, html: string): string => {
  const root = parse(html)

  // Modify displays and maths elements.
  const displays = root.querySelectorAll('.katex-display')
  for (const display of displays) {
    display.replaceWith(`<div class="katex-display">${display.innerHTML}</div>`)
  }
  const maths = root.querySelectorAll('.math-rendered')
  for (const math of maths) {
    // Modify the math elements based on data attributes.
    const latex = math.getAttribute('data-latex')
    if (latex) {
      const display = math.getAttribute('data-latex-display') === 'true'
      const mathTag = display ? `<div class="katex-display"><math displaystyle>${latex}</math></div>` : `<math>${latex}</math>`
      math.replaceWith(mathTag)
    }
  }

  // Modify bubble elements.
  const bubbles = root.querySelectorAll('.bubble')
  for (const bubble of bubbles) {
    let attributes = ''
    const contentWidth = bubble.getAttribute('data-content-width')
    if (contentWidth) {
      attributes += ` data-api-v2-content-width="${contentWidth}"`
    }
    const variant = bubble.getAttribute('data-variant')
    if (variant) {
      attributes += ` class="${variant}"`
    }
    bubble.replaceWith(`<div${attributes}>${bubble.innerHTML}</div>`)
  }

  // Modify image elements.
  const images = root.querySelectorAll('img')
  for (const image of images) {
    // Modify the 'src' attribute of images
    const src = image.getAttribute('src')
    if (!src) {
      continue
    }
    if (src.startsWith('/')) {
      image.setAttribute('src', site.host + src)
    }

    const dark = image.getAttribute('data-src-dark')
    if (dark && dark.startsWith('/')) {
      image.setAttribute('data-src-dark', site.host + dark)
    }
  }

  // Modify representation elements.
  const representations = root.querySelectorAll('.representation')
  for (let i = 0; i < representations.length; i++) {
    const representation = representations[i]
    const id = representation.getAttribute('data-geogebra-id')
    representation.replaceWith(`<div id="representation-${i + 1}" class="plot" data-api-v2-geogebra-id="${id}" data-api-v2-geogebra-image="${site.host}/img/lessons/${lesson.level}/${lesson.id}/${id}.png"></div>`)
  }

  // Return the modified HTML content.
  return root.toString()
}
