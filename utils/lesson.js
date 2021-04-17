function buildBrowserLessonTitle (level, lesson, isSummary) {
  let result = `${level.name} > ${lesson.title}`
  if (isSummary) {
    result += ' > Fiche résumée'
  }
  return result
}

function getAvatarURL (author) {
  const username = author == null || author.length === 0 ? 'Anonyme' : author
  if (username === 'Skyost') {
    return 'https://skyost.eu/assets/img/skyost.png'
  }
  return `https://avatars.dicebear.com/api/bottts/${username}.svg`
}

module.exports = { buildBrowserLessonTitle, getAvatarURL }
