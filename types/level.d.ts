export type LevelId = 'premiere' | 'terminale'

export interface Level {
  id: LevelId,
  order: number,
  name: string,
  image: string,
  description: string
}
