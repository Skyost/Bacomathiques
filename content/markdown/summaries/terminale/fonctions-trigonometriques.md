## Sinus et cosinus

### Définition

Dans tout le cours, le plan sera muni d'un repère orthonormé $(O; \overrightarrow{i}; \overrightarrow{j})$. Il sera
également muni d'un cercle $\mathcal{C}$ appelé **cercle trigonométrique** de centre $O$ et de rayon $1$ orienté dans le
sens inverse des aiguilles d'une montre (c'est le **sens direct**) :

<representation geogebra-id="t52gsb2h"></representation>

<bubble variant="formula">

#### Cosinus et sinus

Soit $M$ un point quelconque situé sur le cercle $\mathcal{C}$ faisant un angle $x$ avec l'axe des abscisses. Les
coordonnées de $M$ sont :

* L'abscisse de $M$ appelée **cosinus** est notée $\cos(x)$.
* L'ordonnée de $M$ appelée **sinus** est notée $\sin(x)$.
* Pour tout $x \in \mathbb{R}$, on a $-1 \leq \cos(x) \leq 1$ et $-1 \leq \sin(x) \leq 1$.

</bubble>

### Périodicité

Les fonctions sinus et cosinus sont périodiques de période $2\pi$.

<bubble variant="formula">

#### Périodicité

Ainsi pour tout $x$ réel et $k$ entier relatif :

* $\cos(x) = \cos(x + 2k\pi)$
* $\sin(x) = \sin(x + 2k\pi)$

</bubble>

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
* $\cos(\frac{\pi}{2} - x) = \sin(x)$
* $\sin(\frac{\pi}{2} - x) = \cos(x)$
* $\cos(x + \frac{\pi}{2}) = -\sin(x)$
* $\sin(x + \frac{\pi}{2}) = \cos(x)$
* $\cos(x + y) = \cos(x) \times \cos(y) - \sin(x) \times \sin(y)$
* $\sin(x + y) = \sin(x) \times \cos(y) + \cos(x) \times \sin(y)$
* $\cos(x)^2 + \sin(x)^2 = 1$

</bubble>

### Résolution d'équations

Il est possible de résoudre des équations incluant des sinus et des cosinus.

<bubble variant="formula">

#### Résolution d'équations

Soient $x$ et $y$ deux réels. On a les relations suivantes :

* $\cos(x) = \cos(y) \iff \text{ il existe } k \in \mathbb{Z} \text{ tel que } \begin{cases} y = x + 2k\pi \\ \text{ou}
  \\ y = -x + 2k\pi\end{cases}$
* $\sin(x) = \sin(y) \iff \text{ il existe } k \in \mathbb{Z} \text{ tel que } \begin{cases} y = x + 2k\pi \\ \text{ou}
  \\ y = \pi - x + 2k\pi\end{cases}$

</bubble>

Comme précédemment, ces formules peuvent se retrouver à l'aide du cercle trigonométrique.

### Fonctions réciproques

<bubble variant="formula">

#### Définition

Soient $x$ et $y$ $\in \mathbb{R}$, on admettra qu'il existe une **fonction réciproque** à $\cos$ (notée $\arccos$) et
une **fonction réciproque** à $\sin$ (notée $\arcsin$). On a les relations suivantes pour tout $x \in [0; 2\pi]$ et $y
\in [-1; 1]$ :

* $\cos(x) = y \iff x = \arccos(y)$
* $\sin(x) = y \iff x = \sin(y)$

</bubble>

Cela signifie qu'à tout $x \in [0; 2\pi]$, la fonction $\arccos$ y associe son **antécédent** $y$ par rapport à $\cos$ (
pareil pour $\arcsin$ avec $\sin$). Ces fonctions (accessibles depuis la calculatrice) peuvent également être utilisées
pour résoudre certains types d'équations.

## Étude des fonctions trigonométriques

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

<bubble variant="formula">

#### Signe et variation de la fonction cosinus

![Tableau de variations de la fonction cosinus](/img/lessons/terminale/fonctions-trigonometriques/variations-cos.svg)

Veuillez noter que ce tableau est périodique de période $2\pi$.

</bubble>

<bubble variant="formula">

#### Signe et variation de la fonction sinus

![Tableau de variations de la fonction sinus](/img/lessons/terminale/fonctions-trigonometriques/variations-sin.svg)

Ce tableau est également périodique de période $2\pi$.

</bubble>

### Limite

Les fonctions trigonométriques ont pour particularité de **ne pas admettre de limite** en $\pm\infty$. Ceci provenant du
fait que ces fonctions sont périodiques et que leur valeur oscille entre $-1$ et $1$.

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

<representation geogebra-id="zhwqmkjd"></representation>

De même pour la fonction sinus :

<representation geogebra-id="gkpmaugu"></representation>

On remarque sur ces graphiques plusieurs propriétés données : parité, signe, périodicité, etc.
