export interface Lesson {
  id: string;
  title: string;
  caption: string;
  excerpt: string;
  level: string;
  chapter: string;
}

export interface Level {
  name: string;
}

function prependChapterToTitle (lesson: Lesson): string {
  return `Chapitre ${romanize(parseInt(lesson.chapter))} – ${lesson.title}`
}

function getLessonPreviewImage (lesson: Lesson): string {
  return `/img/lessons/${lesson.level}/${lesson.id}/preview.jpg`
}

function getAvatarURL (author: string): string {
  const username = author == null || author.length === 0 ? 'Anonyme' : author
  if (username === 'Skyost') {
    return 'https://skyost.eu/assets/img/skyost.png'
  }
  return `https://avatars.dicebear.com/api/bottts/${username}.svg`
}

const levels = {
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

export { prependChapterToTitle, getLessonPreviewImage, getAvatarURL, levels }
