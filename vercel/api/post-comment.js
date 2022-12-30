import { Octokit } from '@octokit/core'
import { v4 as uuidv4 } from 'uuid'
import yaml from 'yaml'
import { createAppAuth } from '@octokit/auth-app'
import { AkismetClient } from 'akismet-api'
import site from '../../site'

export default async function handler (request, response) {
  if (!allowCors(request, response)) {
    return
  }

  if (!request.body || !request.body.level || !request.body.lesson || !request.body.message || !request.body.author || !request.body.client) {
    response.status(400).json({
      success: false,
      message: 'Il manque un paramètre.'
    })
    return
  }

  const id = uuidv4()
  const comment = {
    _id: id,
    level: request.body.level,
    lesson: request.body.lesson,
    message: request.body.message,
    author: request.body.author,
    date: Math.round((new Date()).getTime() / 1000),
    client: request.body.client
  }

  if (!await askimetCheck(request, comment)) {
    response.status(400).json({
      success: false,
      message: 'Une erreur est survenue. Veuillez réessayer plus tard.'
    })
    return
  }

  const octokit = new Octokit({
    authStrategy: createAppAuth,
    auth: {
      appId: process.env.GITHUB_APP_ID,
      privateKey: process.env.GITHUB_APP_PRIVATE_KEY,
      installationId: process.env.GITHUB_APP_INSTALLATION_ID
    }
  })

  const branch = `comment-${id}`
  let githubResponse = await octokit.request('GET /repos/{owner}/{repo}/commits', {
    owner: site.github.username,
    repo: site.github.repository,
    per_page: 1
  })

  if (githubResponse.status !== 200) {
    response.status(githubResponse.status).json({
      success: false,
      message: 'Failed to get latest commit.'
    })
    return
  }

  const latestCommit = githubResponse.data[0].sha
  githubResponse = await octokit.request('POST /repos/{owner}/{repo}/git/refs', {
    owner: site.github.username,
    repo: site.github.repository,
    ref: `refs/heads/${branch}`,
    sha: latestCommit
  })

  if (githubResponse.status !== 201) {
    response.status(githubResponse.status).json({
      success: false,
      message: 'Failed to create a new ref.'
    })
    return
  }

  const pullRequestTitle = `Nouveau commentaire par ${comment.author} (${id})`
  githubResponse = await octokit.request('PUT /repos/{owner}/{repo}/contents/{path}', {
    owner: site.github.username,
    repo: site.github.repository,
    path: `content/comments/${id}.yml`,
    message: pullRequestTitle,
    content: btoa(yaml.stringify(comment)),
    branch
  })

  if (githubResponse.status !== 201) {
    response.status(githubResponse.status).json({
      success: false,
      message: 'Failed to create comment file.'
    })
    return
  }

  githubResponse = await octokit.request('POST /repos/{owner}/{repo}/pulls', {
    owner: site.github.username,
    repo: site.github.repository,
    title: pullRequestTitle,
    body: `Nouveau commentaire sur Bacomathiques !

| Champ   | Contenu                                 |
| ------- | --------------------------------------- |
| Niveau  | ${comment.level}                   |
| Cours   | ${comment.lesson}                  |
| Message | ${comment.message}                 |
| Auteur  | ${comment.author}                  |
| Date    | ${comment.date}                    |
| Client  | ${comment.client}                  |
`,
    head: branch,
    base: 'master'
  })

  if (githubResponse.status !== 201) {
    response.status(githubResponse.status).json({
      success: false,
      message: 'Failed to create pull request.'
    })
    return
  }

  response.status(githubResponse.status).json({
    success: true,
    message: 'Pull request created with success.'
  })
}

function allowCors (request, response) {
  response.setHeader('Access-Control-Allow-Credentials', true)
  response.setHeader('Access-Control-Allow-Origin', site.host)
  response.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT')
  response.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version, Authorization, Origin'
  )
  if (request.method.toUpperCase() === 'OPTIONS') {
    response.status(200).send()
    return false
  }
  return true
}

async function askimetCheck (request, comment) {
  const client = new AkismetClient({
    key: process.env.ASKIMET_API_KEY,
    blog: 'https://vercel.bacomathiqu.es'
  })

  return await client.checkSpam({
    ip: request.headers['x-forwarded-for'],
    useragent: request.headers['User-Agent'],
    content: comment.message,
    name: comment.author,
    type: 'comment'
  })
}
