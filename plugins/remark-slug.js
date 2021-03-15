const toString = require('mdast-util-to-string')
const visit = require('unist-util-visit')
const slugs = require('github-slugger')()

module.exports = slug

function slug () {
  return transformer
}

function transformer (ast) {
  slugs.reset()

  visit(ast, 'heading', (node) => {
    if (node.depth >= 4) {
      return
    }

    const data = node.data || (node.data = {})
    const props = data.hProperties || (data.hProperties = {})
    let id = props.id

    id = id ? slugs.slug(id, true) : slugs.slug(toString(node), false)

    data.id = id
    props.id = id
  })
}
