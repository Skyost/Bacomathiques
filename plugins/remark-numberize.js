const visit = require('unist-util-visit')

module.exports = () => (tree) => {
  let h2Index = 0
  let h3Index = 0
  visit(tree, 'heading', (node) => {
    const depth = node.depth
    if (depth === 2) {
      h3Index = 0
    }

    const prefixFunction = getPrefixFunction(depth)
    const firstText = node.children.find(child => child.type === 'text')
    if (prefixFunction !== null) {
      firstText.value = prefixFunction(depth === 2 ? ++h2Index : ++h3Index) + firstText.value
    }
  })
}

function getPrefixFunction (depth) {
  switch (depth) {
    case 2:
      return index => `${romanize(index)} – `
    case 3:
      return index => `${index}. `
  }
  return null
}

function romanize (num) {
  if (!+num) {
    return false
  }
  const digits = String(+num).split('')
  const key = ['', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM',
    '', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC',
    '', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX']
  let roman = ''
  let i = 3
  while (i--) {
    roman = (key[+digits.pop() + (i * 10)] || '') + roman
  }
  return Array(+digits.join('') + 1).join('M') + roman
}
