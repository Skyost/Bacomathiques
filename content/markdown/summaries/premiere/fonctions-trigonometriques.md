## Le cercle trigonométrique

### Définition

Dans tout le cours, le plan sera muni d'un repère orthonormé $(O ; \overrightarrow{\imath} ; \overrightarrow{\jmath})$.
Il sera également muni d'un cercle $\mathcal{C}$ appelé **cercle trigonométrique** de centre $O$ et de rayon $1$ orienté
dans le sens inverse des aiguilles d'une montre (c'est le **sens direct**) :

<representation geogebra-id="t52gsb2h"></representation>

<bubble variant="formula">

#### Cosinus et sinus

Soit $M$ un point quelconque situé sur le cercle $\mathcal{C}$ faisant un angle $x$ avec l'axe des abscisses. Les
coordonnées de $M$ sont :

* L'abscisse de $M$ appelée **cosinus** est notée $\cos(x)$.
* L'ordonnée de $M$ appelée **sinus** est notée $\sin(x)$.
* Pour tout $x \in \mathbb{R}$, on a $-1 \leq \cos(x) \leq 1$ et $-1 \leq \sin(x) \leq 1$.

</bubble>

### Enroulement de la droite des réels autour du cercle trigonométrique

Il est possible d'enrouler la droite des réels autour du cercle $\mathcal{C}$ dans le sens inverse des aiguilles d'une
montre :

<representation geogebra-id="b4vazqb5"></representation>

Ainsi, puisque l'on peut enrouler infiniment cette droite autour du cercle, les fonctions sinus et cosinus sont
périodiques de période $2\pi$.

<bubble variant="formula">

#### Périodicité

Ainsi, pour tout $x$ réel et $k$ entier relatif :

* $\cos(x) = \cos(x + 2k\pi)$
* $\sin(x) = \sin(x + 2k\pi)$

</bubble>

### Le radian

<bubble variant="formula">

#### Définition

Le **radian** est une unité de mesure permettant de mesurer des **angles orientés**. La **mesure** en radians d'un angle
vaut la longueur de l'arc de $\mathcal{C}$ que cet angle intercepte.

</bubble>

<representation geogebra-id="yh9n8feb"></representation>

## Étude des fonctions trigonométriques

### Formules de trigonométrie

<bubble variant="formula">

#### Formules

On a les relations suivantes pour tout $x \in \mathbb{R}$ :

* $\cos(-x) = \cos(x)$ (la fonction cosinus est **paire**)
* $\sin(-x) = -\sin(x)$ (la fonction sinus est **impaire**)
* $\cos(x + \pi) = -\cos(x)$
* $\sin(x + \pi) = -\sin(x)$
* $\cos(x - \pi) = -\cos(x)$
* $\sin(x - \pi) = \sin(x)$
* $\cos \left(\frac{\pi}{2} - x \right) = \sin(x)$
* $\sin \left(\frac{\pi}{2} - x \right) = \cos(x)$
* $\cos \left(x + \frac{\pi}{2} \right) = -\sin(x)$
* $\sin \left(x + \frac{\pi}{2} \right) = \cos(x)$
* $\cos(x + y) = \cos(x) \times \cos(y) - \sin(x) \times \sin(y)$
* $\sin(x + y) = \sin(x) \times \cos(y) + \cos(x) \times \sin(y)$
* $\cos(x)^2 + \sin(x)^2 = 1$

</bubble>

### Dérivée

<bubble variant="formula">

#### Dérivée d'une composée

Soit une fonction $u$ dérivable sur un intervalle $I$, on a pour tout $x$ appartenant à cet intervalle :

* $\cos'(u(x)) = -u'(x)\sin(u(x))$
* $\sin'(u(x)) = u'(x)\cos(u(x))$

</bubble>

<bubble variant="formula">

#### Dérivée

Ainsi, si pour tout $x \in I$ on a $u(x) = x$, on trouve :

* $\cos'(x) = -\sin(x)$
* $\sin'(x) = \cos(x)$

</bubble>

### Signe et variations

L'étude du signe des dérivées des fonctions trigonométriques permet d'obtenir les variations de celles-ci. Nous allons
donc voir le signe et les variations de ces fonctions.

<bubble variant="formula" content-width="big">

#### Signe et variation de la fonction cosinus

![Tableau de variations de la fonction cosinus](/img/lessons/premiere/fonctions-trigonometriques/variations-cos.svg)

Veuillez noter que ce tableau est périodique de période $2\pi$.

</bubble>

<bubble variant="formula" content-width="big">

#### Signe et variation de la fonction sinus

![Tableau de variations de la fonction sinus](/img/lessons/premiere/fonctions-trigonometriques/variations-sin.svg)

Ce tableau est également périodique de période $2\pi$.

</bubble>

### Valeurs remarquables

<bubble variant="formula">

#### Valeurs remarquables

Voici un tableau regroupant quelques valeurs remarquables de sinus et de cosinus :

| Valeur de $x$ (à $2k\pi$ près, $k \in \mathbb{Z}$) | Valeur de $\cos(x)$                  | Valeur de $\sin(x)$                 |
| -------------------------------------------------- | ------------------------------------ | ----------------------------------- |
| $0$                                                | $1$                                  | $0$                                 |
| $\displaystyle{\frac{\pi}{6}}$                     | $\displaystyle{\frac{\sqrt{3}}{2}}$  | $\displaystyle{\frac{1}{2}}$        |
| $\displaystyle{\frac{\pi}{4}}$                     | $\displaystyle{\frac{\sqrt{2}}{2}}$  | $\displaystyle{\frac{\sqrt{2}}{2}}$ |
| $\displaystyle{\frac{\pi}{3}}$                     | $\displaystyle{\frac{1}{2}}$         | $\displaystyle{\frac{\sqrt{3}}{2}}$ |
| $\displaystyle{\frac{\pi}{2}}$                     | $0$                                  | $1$                                 |
| $\displaystyle{\frac{2\pi}{3}}$                    | $\displaystyle{-\frac{1}{2}}$        | $\displaystyle{\frac{\sqrt{3}}{2}}$ |
| $\displaystyle{\frac{3\pi}{4}}$                    | $\displaystyle{-\frac{\sqrt{2}}{2}}$ | $\displaystyle{\frac{\sqrt{2}}{2}}$ |
| $\displaystyle{\frac{5\pi}{6}}$                    | $\displaystyle{-\frac{\sqrt{3}}{2}}$ | $\displaystyle{\frac{1}{2}}$        |
| $\pi$                                              | $-1$                                 | $0$                                 |

</bubble>

### Représentation graphique

À l'aide de toutes les informations et valeurs données précédemment, il est possible d'établir une représentation
graphique de la fonction cosinus :

<representation geogebra-id="gkpmaugu"></representation>

De même pour la fonction sinus :

<representation geogebra-id="zhwqmkjd"></representation>

On remarque sur ces graphiques plusieurs propriétés données : parité, signe, périodicité, etc.
