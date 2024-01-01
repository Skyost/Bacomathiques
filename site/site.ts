// noinspection ES6PreferShortImport

import { romanize } from '../utils/utils'
import type { Lesson, Level } from '../types'

interface Mobile {
  googlePlay: string
  appStore: string
}

export interface Github {
  username: string
  repository: string
}

interface Site {
  name: string
  description: string
  host: string
  mobile: Mobile
  github: Github
  moderators: string[]
}

export const site: Site = {
  name: 'Bacomathiques',
  description: 'Bacomathiques est un petit site web qui contient tout ce dont vous avez besoin pour réviser vos maths en toute tranquillité de la Première à la Terminale ! Que vous cherchiez à passer votre Baccalauréat ou que vous souhaitiez simplement réviser votre cours ; tout est possible et tout est gratuit. Au programme : cours de mathématiques gratuits, téléchargeables et imprimables, annales et corrigés des sujets précédents, etc.',
  host: 'https://bacomathiqu.es',
  mobile: {
    googlePlay: 'https://play.google.com/store/apps/details?id=fr.bacomathiques&utm_source=bacomathiqu.es',
    appStore: 'https://itunes.apple.com/app/id1458503418'
  },
  github: {
    username: 'Skyost',
    repository: 'Bacomathiques'
  },
  moderators: ['Skyost']
}

export const levels: {[key:string]:Level} = {
  premiere: {
    id: 'premiere',
    order: 1,
    name: 'Première',
    image: '/img/levels/premiere.svg',
    description: 'Dans cette section vous aurez accès à tous les cours de Première (spécialité mathématiques). Celui-ci se divise en cinq grandes parties : analyse, algèbre, géométrie, probabilités et algorithmique.'
  },
  terminale: {
    id: 'terminale',
    order: 2,
    name: 'Terminale',
    image: '/img/levels/terminale.svg',
    description: "Dans cette section vous aurez accès à tous les cours de Terminale (spécialité mathématiques). Comme le cours de Première, on y retrouve cinq grandes parties : analyse, algèbre, géométrie, probabilités et algorithmique. Cependant, l'abstraction et le niveau de détail y sont plus élevés."
  }
}

export const prependChapterToTitle = (lesson: Lesson): string => `Chapitre ${romanize(lesson.chapter)} – ${lesson.title}`

export const getAvatarUrl = (author: string): string => {
  const username = author == null || author.length === 0 ? 'Anonyme' : author
  if (username === 'Skyost') {
    return 'https://skyost.eu/images/skyost.png'
  }
  return `https://api.dicebear.com/7.x/bottts/svg?seed=${username}`
}
