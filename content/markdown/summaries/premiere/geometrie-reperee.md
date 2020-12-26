## Le produit scalaire

### Définition

<bubble variant="formula">

#### Définition

Soient $\overrightarrow{u} = \begin{pmatrix} {x_1} \\ {y_1}\end{pmatrix}$ et $\overrightarrow{v} = \begin{pmatrix} {x_2}
\\ {y_2}\end{pmatrix}$ deux vecteurs du plan (c'est-à-dire possédant chacun deux coordonnées).

Le **produit scalaire** entre $u$ et $v$, noté $\overrightarrow{u} \cdot \overrightarrow{v}$ est le réel suivant :

$\overrightarrow{u} \cdot \overrightarrow{v} = x_1 x_2 + y_1 y_2$.

</bubble>

<bubble variant="formula">

#### Propriétés

Soient $\overrightarrow{u}$, $\overrightarrow{v}$ et $\overrightarrow{w}$ des vecteurs du plan et $\lambda \in
\mathbb{R}$, on a les propriétés suivantes :

* $\overrightarrow{u} \cdot \overrightarrow{v} = \overrightarrow{v} \cdot \overrightarrow{u}$
* $\overrightarrow{u} \cdot (\overrightarrow{v} + \overrightarrow{w}) = \overrightarrow{u} \cdot \overrightarrow{v} +
  \overrightarrow{u} \cdot \overrightarrow{w}$
* $\lambda(\overrightarrow{u} \cdot \overrightarrow{v}) = (\lambda \overrightarrow{u}) \cdot \overrightarrow{v} =
  \overrightarrow{u} \cdot (\lambda \overrightarrow{v})$

</bubble>

À l'aide du produit scalaire, il est possible de calculer la **norme** d'un vecteur.

<bubble variant="formula">

#### Calcul de la norme

Soit $\overrightarrow{u} = \begin{pmatrix} {x} \\ {y} \end{pmatrix}$ un vecteur du plan : sa norme (notée
$||\overrightarrow{u}||$) vaut $||\overrightarrow{u}|| = \sqrt{\overrightarrow{u} \cdot \overrightarrow{u}} = \sqrt{x^2
+ y^2}$.

</bubble>

### Calcul

Il existe plusieurs méthode pour calculer le produit scalaire en fonction de la situation dans laquelle on se trouve.

<bubble variant="formula">

#### Calcul avec un angle

Soient $\overrightarrow{u}$, $\overrightarrow{v}$ deux vecteurs du plan et $\theta$ l'angle orienté entre les deux. On
a :

$\overrightarrow{u} \cdot \overrightarrow{v} = ||\overrightarrow{u}|| \times ||\overrightarrow{v}|| \times \cos(\theta)$

</bubble>

<bubble variant="formula">

#### Calcul avec un projeté orthogonal

Soient $A$, $B$ et $C$ trois points distincts du plan. On pose $P$ le projeté orthogonal de $C$ sur $(AB)$. Alors :

* Si $P \in [AB)$ alors $\overrightarrow{AB} \cdot \overrightarrow{AC} = AB \times AP$
* Si $P \notin [AB)$ alors $\overrightarrow{AB} \cdot \overrightarrow{AC} = - AB \times AP$

</bubble>

Si on ne possède que les normes de nos vecteurs, il est possible d'utiliser la formule de polarisation.

<bubble variant="formula">

#### Formule de polarisation

Soient $\overrightarrow{u}$ et $\overrightarrow{v}$ deux vecteurs du plan :

$\overrightarrow{u} \cdot \overrightarrow{v} = \displaystyle{\frac{1}{2} \left(||\overrightarrow{u + v}||^2 -
||\overrightarrow{u}||^2 - ||\overrightarrow{v}||^2\right)}$.

</bubble>

### Théorème d'Al-Kashi

Le **théorème d'Al-Kashi** permet de calculer la longueur des côtés de n'importe quel triangle, qu'il soit rectangle ou
non. Ainsi,

<bubble variant="formula">

#### Théorème d'Al-Kashi

Soient $A$, $B$ et $C$ trois points du plan non alignés (formant donc un triangle). On pose $a = BC$, $b = CA$ et $c =
AB$. Alors :

$c^2 = a^2 + b^2 - 2 \times a \times b \times \cos(\widehat{ACB})$

</bubble>

## Géométrie

### Équation cartésienne d'une droite

<bubble variant="formula">

#### Définition

Il est possible de décrire tous les points appartenant à une droite $\mathcal{D}$ par une équation appelée **équation
cartésienne**.

Une équation cartésienne de $\mathcal{D}$ est de la forme $ax + by + c = 0$ avec $a \neq 0$, $b \neq 0$ et $c$ réels, et
où $x$ et $y$ sont des coordonnées de points.

</bubble>

### Vecteurs directeurs d'une droite

<bubble variant="formula">

#### Définition

Soient $\mathcal{D}$ une droite et $\overrightarrow{u}$ un vecteur du plan non nul. Alors $\overrightarrow{u}$ est un **
vecteur directeur** de $\mathcal{D}$ s'il existe deux points $A$ et $B$ appartenant à $\mathcal{D}$ et tels que
$\overrightarrow{u} = \overrightarrow{AB}$.

</bubble>

<representation geogebra-id="kccrxa9q"></representation>

De plus, on a la propriété suivante qui peut s'avérer très utile :

<bubble variant="formula">

#### Colinéarité des vecteurs directeurs

$\overrightarrow{v}$ est un vecteur directeur de $\mathcal{D}$ si et seulement s'il est colinéaire au vecteur
$\overrightarrow{u}$ précédent.

</bubble>

Tous les vecteurs directeurs d'une droite sont donc colinéaires entre eux.

Il est facile de trouver un vecteur directeur d'une droite dont on connaît l'équation cartésienne.

<bubble variant="formula">

#### Coordonnées d'un vecteur directeur

Soit $\mathcal{D}$ une droite définie par l'équation $ax + by + c = 0$. Alors $\overrightarrow{u} = \begin{pmatrix} -b
\\ a\end{pmatrix}$ est un vecteur directeur de $\mathcal{D}$.

</bubble>

<bubble variant="formula">

#### Propriétés

Soient $\mathcal{D}_1$ et $\mathcal{D}_2$ deux droites respectivement de vecteurs directeurs $\overrightarrow{u}$ et
$\overrightarrow{v}$. Alors :

* $\mathcal{D}_1$ est parallèle à $\mathcal{D}_2$ si et seulement si $\overrightarrow{u}$ et $\overrightarrow{v}$ sont
  colinéaires.
* $\mathcal{D}_1$ est perpendiculaire à $\mathcal{D}_2$ si et seulement si $\overrightarrow{u} \cdot \overrightarrow{v}
  = 0$.

</bubble>

<bubble variant="formula">

#### Orthogonalité

Si $\overrightarrow{u} \cdot \overrightarrow{v} = 0$ alors $\overrightarrow{u}$ et $\overrightarrow{v}$ sont dits **
orthogonaux**.

</bubble>

### Vecteurs normaux à une droite

<bubble variant="formula">

#### Définition

Soient $\mathcal{D}$ une droite de vecteur directeur $\overrightarrow{u}$ et $\overrightarrow{n}$ un vecteur du plan non
nul. Alors $\overrightarrow{n}$ est un **vecteur normal** à $\mathcal{D}$ si $\overrightarrow{u}$ et
$\overrightarrow{n}$ sont orthogonaux entre eux.

</bubble>

<representation geogebra-id="ydshrp8y"></representation>

De plus, on a la propriété suivante qui peut s'avérer très utile :

<bubble variant="formula">

#### Colinéarité des vecteurs normaux

$\overrightarrow{m}$ est un vecteur normal à $\mathcal{D}$ si et seulement s'il est colinéaire au vecteur
$\overrightarrow{n}$ précédent.

</bubble>

Tous les vecteurs normaux d'une droite sont donc colinéaires entre eux.

Il est facile de trouver un vecteur normal à une droite dont on connaît l'équation cartésienne.

<bubble variant="formula">

#### Coordonnées d'un vecteur normal

Soit $\mathcal{D}$ une droite définie par l'équation $ax + by + c = 0$. Alors $\overrightarrow{n} = \begin{pmatrix} a \\
b\end{pmatrix}$ est un vecteur normal à $\mathcal{D}$.

</bubble>

Soient $\mathcal{D}_1$ et $\mathcal{D}_2$ deux droites respectivement de vecteurs directeurs $\overrightarrow{u}$ et
$\overrightarrow{v}$. Alors :

<bubble variant="formula">

$\mathcal{D}_1$ est perpendiculaire à $\mathcal{D}_2$ si et seulement si $\overrightarrow{u}$ est normal à $\mathcal{D}_
2$.

</bubble>

### Description d'un cercle

De la même manière que pour les droites, il est possible de décrire l'ensemble des points appartenant à un cercle à
l'aide d'une équation.

<bubble variant="formula">

#### Description par équation cartésienne

Soit $\mathcal{C}$ un cercle de centre $O = (x_O; y_O)$ et de rayon $R$.

Une équation cartésienne de $\mathcal{C}$ est de la forme $(x - x_O)^2 + (y - y_O)^2 = R^2$ avec $x$ et $y$ qui sont des
coordonnées de points.

</bubble>

On peut de manière équivalente, décrire un cercle à l'aide du produit scalaire.

<bubble variant="formula">

#### Description par produit scalaire

Soient $A$ et $B$ deux points du plan. Alors l'ensemble des points $M$ tels que $\overrightarrow{MA} \cdot
\overrightarrow{MB} = 0$ est le cercle de diamètre $[AB]$.

</bubble>

En réalité, les deux points précédents sont deux manières différentes de décrire un cercle.
