const SITE_NAME = 'Bacomathiques'
const SITE_DESCRIPTION = 'Bacomathiques est un petit site web qui contient tout ce dont vous avez besoin pour réviser vos maths en toute tranquillité de la Première à la Terminale ! Que vous cherchiez à passer votre Baccalauréat ou que vous souhaitiez simplement réviser votre cours ; tout est possible et tout est gratuit. Au programme : cours de mathématiques gratuits, téléchargeables et imprimables, annales et corrigés des sujets précédents, etc.'
const HOST_NAME = 'https://bacomathiqu.es'
const GOOGLE_PLAY = 'https://play.google.com/store/apps/details?id=fr.bacomathiques&utm_source=bacomathiqu.es'
const APP_STORE = 'https://itunes.apple.com/app/id1458503418'
const GITHUB = 'https://github.com/Skyost/Bacomathiques'

function getCurrentAddress (route) {
  return `${HOST_NAME}${route.path}`
}

module.exports = {
  SITE_NAME,
  SITE_DESCRIPTION,
  HOST_NAME,
  GOOGLE_PLAY,
  APP_STORE,
  GITHUB,
  getCurrentAddress
}
