import { LevelId } from '~/types/level'

export interface Comment {
  _id: string,
  level: LevelId,
  lesson: string,
  message: string,
  author: string,
  date: number,
  client: string
}
