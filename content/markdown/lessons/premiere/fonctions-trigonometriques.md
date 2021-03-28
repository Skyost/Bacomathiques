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

<bubble variant="tip">

#### Longueur d'arcs de cercle

L'enroulement de cette droite permet ainsi de mesurer des longueurs d'arcs sur le cercle $\mathcal{C}$. Ainsi, la
longueur d'un quart de cercle vaut $\displaystyle{\frac{\pi}{2}}$ (celle d'un demi-cercle vaut $\pi$ et celle d'un
cercle vaut $2\pi$).

</bubble>

Ainsi, puisque l'on peut enrouler infiniment cette droite autour du cercle, les fonctions sinus et cosinus sont
périodiques de période $2\pi$.

<bubble variant="formula">

#### Périodicité

Ainsi, pour tout $x$ réel et $k$ entier relatif :

* $\cos(x) = \cos(x + 2k\pi)$
* $\sin(x) = \sin(x + 2k\pi)$

</bubble>

<bubble variant="tip">

Concrètement, cela signifie que pour tout $x \in \mathbb{R}$, $\cos(x) = \cos(x + 2\pi) = \cos(x + 4\pi) = \dots = \cos(
x + 2k\pi)$ et idem pour $\sin(x)$.

</bubble>

### Le radian

<bubble variant="formula">

#### Définition

Le **radian** est une unité de mesure permettant de mesurer des **angles orientés**. La **mesure** en radians d'un angle
vaut la longueur de l'arc de $\mathcal{C}$ que cet angle intercepte.

</bubble>

<representation geogebra-id="yh9n8feb"></representation>

<bubble variant="tip">

Cela veut simplement dire qu'un angle en radian n'est rien d'autre qu'une mesure de longueur d'arc du cercle
trigonométrique.

Attention cependant, comme le radian est une unité de mesure d'angles orientés, mesurer $\frac{\pi}{2}$ ou
$-\frac{\pi}{2}$ radians n'est pas la même chose car les angles ont **un sens**.

Si l'angle a une mesure positive, alors il est orienté dans le sens inverse des aiguilles d'une montre (le sens direct).

Si l'angle a une mesure négative, alors il est orienté dans le sens des aiguilles d'une montre (le sens indirect).

</bubble>

## Étude des fonctions trigonométriques

### Formules de trigonométrie

<bubble variant="formula">

#### Formules

On a les relations suivantes pour tout $x \in \mathbb{R}$ :

* $\cos(-x) = \cos(x)$ (la fonction cosinus est **paire**)
* $\sin(-x) = -\sin(x)$ (la fonction sinus est **impaire**)
* $\cos(\pi + x) = -\cos(x)$
* $\sin(\pi + x) = -\sin(x)$
* $\cos(\pi - x) = -\cos(x)$
* $\sin(\pi - x) = \sin(x)$
* $\cos \left(\frac{\pi}{2} + x \right) = -\sin(x)$
* $\sin \left(\frac{\pi}{2} + x \right) = \cos(x)$
* $\cos \left(\frac{\pi}{2} - x \right) = \sin(x)$
* $\sin \left(\frac{\pi}{2} - x \right) = \cos(x)$
* $\cos(x + y) = \cos(x) \times \cos(y) - \sin(x) \times \sin(y)$
* $\sin(x + y) = \sin(x) \times \cos(y) + \cos(x) \times \sin(y)$
* $\cos(x)^2 + \sin(x)^2 = 1$

</bubble>

<bubble variant="tip">

#### Retrouver les formules

Il n'est aucunement demandé de mémoriser ces formules (sauf les trois dernières). Cependant, il doit être possible de
les retrouver à l'aide du cercle trigonométrique. Ainsi, prenons l'exemple de $\cos(x + \pi)$ :

<representation geogebra-id="xghkwjkf"></representation>

On remarque que l'ordonnée reste la même (le sinus est le même). Cependant, on a bien une abscisse opposée. On a
retrouvé la formule $\cos(x + \pi) = -\cos(x)$.

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
