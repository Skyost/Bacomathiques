function sleeper (ms) {
  return new Promise(resolve => setTimeout(resolve, ms))
}

function normalize (string) {
  return string.normalize('NFD').replace(/\p{Diacritic}/gu, '').toLowerCase()
}

module.exports = { sleeper, normalize }
