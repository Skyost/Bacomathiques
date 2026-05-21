import type { LevelId } from '~/types/level'

export interface Lesson {
  'level': LevelId
  'id': string
  'slug': string
  'title': string
  'chapter': number
  'caption': string
  'description': string
  'difficulty': number
  'specialty'?: boolean
  'pdf': string
  'preview': string
  'title-search': string
}
