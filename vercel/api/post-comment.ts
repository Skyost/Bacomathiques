// noinspection ES6PreferShortImport

import type { VercelRequest, VercelResponse } from '@vercel/node'
import { Octokit } from '@octokit/core'
import { v4 as uuidv4 } from 'uuid'
import * as yaml from 'yaml'
import { createAppAuth } from '@octokit/auth-app'
import { AkismetClient } from 'akismet-api'
import { createPullRequest } from 'octokit-plugin-create-pull-request'
import type { Comment } from '../../types'
import { site } from '../../site/site.js'

export default async function handler (request: VercelRequest, response: VercelResponse) {
  if (!allowCors(request, response)) {
    return
  }

  if (!request.body || !request.body.level || !request.body.lesson || !request.body.message || !request.body.author || !request.body.client) {
    response.status(400).json({
      success: false,
      message: 'Il manque au moins un paramètre.'
    })
    return
  }

  const id = uuidv4()
  const comment: Comment = {
    _id: id,
    level: request.body.level,
    lesson: request.body.lesson,
    message: request.body.message,
    author: request.body.author,
    date: Math.round((new Date()).getTime() / 1000),
    client: request.body.client
  }

  if (await akismetSpam(request, comment)) {
    response.status(400).json({
      success: false,
      message: 'Une erreur est survenue. Veuillez réessayer plus tard.'
    })
    return
  }

  const PullRequestOctokit = Octokit.plugin(createPullRequest)
  const octokit = new PullRequestOctokit({
    authStrategy: createAppAuth,
    auth: {
      appId: process.env.GITHUB_APP_ID,
      privateKey: process.env.GITHUB_APP_PRIVATE_KEY,
      installationId: process.env.GITHUB_APP_INSTALLATION_ID
    }
  })

  const title = `Nouveau commentaire par ${comment.author} (${id})`
  const githubResponse = await octokit.createPullRequest({
    owner: site.github.username,
    repo: site.github.repository,
    title,
    body: `Nouveau commentaire sur Bacomathiques !

| Champ   | Contenu                            |
| ------- | ---------------------------------- |
| Niveau  | ${comment.level}                   |
| Cours   | ${comment.lesson}                  |
| Message | ${comment.message}                 |
| Auteur  | ${comment.author}                  |
| Date    | ${comment.date}                    |
| Client  | ${comment.client}                  |
`,
    head: `comment-${id}`,
    changes: [
      {
        files: {
          [`content/comments/${id}.yml`]: yaml.stringify(comment)
        },
        commit: title
      }
    ]
  })

  const status = githubResponse?.status ?? 500
  if (status) {
    response.status(status).json({
      success: false,
      message: 'Failed to create pull request.'
    })
    return
  }

  response.status(status).json({
    success: true,
    message: 'Pull request created with success.'
  })
}

function allowCors (request: VercelRequest, response: VercelResponse) {
  response.setHeader('Access-Control-Allow-Credentials', 'true')
  response.setHeader('Access-Control-Allow-Origin', site.host)
  // response.setHeader('Access-Control-Allow-Origin', 'http://localhost:3000')
  response.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT')
  response.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version, Authorization, Origin'
  )
  if (request.method?.toUpperCase() === 'OPTIONS') {
    response.status(200).send('')
    return false
  }
  return true
}

async function akismetSpam (request: VercelRequest, comment: Comment) {
  if (!process.env.ASKIMET_API_KEY) {
    return true
  }

  const client = new AkismetClient({
    key: process.env.ASKIMET_API_KEY,
    blog: 'https://vercel.bacomathiqu.es'
  })

  return await client.checkSpam({
    ip: request.headers['x-forwarded-for']!.toString(),
    useragent: request.headers['user-agent'],
    content: comment.message,
    name: comment.author,
    type: 'comment'
  })
}
