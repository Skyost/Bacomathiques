interface Route {
  path: string
}

interface Mobile {
  googlePlay: string;
  appStore: string;
}

interface Github {
  username: string;
  repository: string;
}

class Site {
  name: string
  description: string
  host: string
  mobile: Mobile
  github: Github

  constructor (name: string, description: string, host: string, mobile: Mobile, github: Github) {
    this.name = name
    this.description = description
    this.host = host
    this.mobile = mobile
    this.github = github
  }

  getCurrentAddress (route: Route): string {
    return `${this.host}${route.path}`
  }
}

const site = new Site(
  'Bacomathiques',
  'Bacomathiques est un petit site web qui contient tout ce dont vous avez besoin pour réviser vos maths en toute tranquillité de la Première à la Terminale ! Que vous cherchiez à passer votre Baccalauréat ou que vous souhaitiez simplement réviser votre cours ; tout est possible et tout est gratuit. Au programme : cours de mathématiques gratuits, téléchargeables et imprimables, annales et corrigés des sujets précédents, etc.',
  'https://bacomathiqu.es',
  {
    googlePlay: 'https://play.google.com/store/apps/details?id=fr.bacomathiques&utm_source=bacomathiqu.es',
    appStore: 'https://itunes.apple.com/app/id1458503418'
  },
  {
    username: 'Skyost',
    repository: 'Bacomathiques'
  }
)

export default site
