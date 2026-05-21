import { defineCollection, defineContentConfig, z } from '@nuxt/content'

const level = z.enum(['premiere', 'terminale'])

const tocEntry = z.object({
  id: z.string(),
  text: z.string(),
  depth: z.number(),
  children: z.array(z.any())
})

export default defineContentConfig({
  collections: {
    lessons: defineCollection({
      type: 'data',
      source: {
        include: 'latex/lessons/**/*.tex',
        exclude: [
          'latex/lessons/common.tex',
          'latex/lessons/pandoc.tex'
        ]
      },
      schema: z.object({
        'level': level,
        'id': z.string(),
        'slug': z.string(),
        'title': z.string(),
        'chapter': z.number(),
        'caption': z.string(),
        'description': z.string(),
        'difficulty': z.number(),
        'specialty': z.boolean().optional(),
        'pdf': z.string(),
        'preview': z.string(),
        'title-search': z.string(),
        'body': z.string(),
        'summary': z.string(),
        'toc': z.array(tocEntry)
      })
    }),
    comments: defineCollection({
      type: 'data',
      source: 'comments/**/*.yml',
      schema: z.object({
        _id: z.string(),
        level,
        lesson: z.string(),
        message: z.string(),
        author: z.string(),
        date: z.number(),
        client: z.string()
      })
    }),
    latestCommit: defineCollection({
      type: 'data',
      source: 'latest-commit.json',
      schema: z.object({
        long: z.string(),
        short: z.string()
      })
    })
  }
})
