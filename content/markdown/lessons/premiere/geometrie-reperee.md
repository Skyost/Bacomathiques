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

<bubble variant="tip">

#### Caractéristiques d'un vecteur

On rappelle qu'un vecteur possède 3 caractéristiques :

* Une **norme** (sa longueur, par exemple si $\overrightarrow{u} = \overrightarrow{AB}$ alors $||\overrightarrow{u}|| =
  AB$)
* Un **sens** (exemple : de $A$ vers $B$ ou de haut en bas)
* Une **direction** (la direction de la droite que porte le vecteur, horizontale ou verticale par exemple)

</bubble>

### Calcul

Il existe plusieurs méthodes pour calculer le produit scalaire en fonction de la situation dans laquelle on se trouve.

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

<bubble variant="tip">

#### Utilisation des formules

Il faut vraiment trouver la formule à utiliser selon l'énoncé de l'exercice.

Par exemple, si on se trouve dans un repère et que l'on a les coordonnées des vecteurs, on pourra utiliser la formule de
la [définition](#définition). À l'inverse, si on ne possède pas les coordonnées de nos vecteurs mais que l'on possède
leur normes, il est possible d'utiliser la formule de polarisation.

Voici un tableau récapitulatif pour $\overrightarrow{u}$ et $\overrightarrow{v}$ vecteurs du plan :

| Données                                                                                                                                                                       | Formule                                                                                                                                                                                                | À utiliser si on possède...                                                                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------- |
| $\overrightarrow{u} = \begin{pmatrix} {x_1} \\ {y_1} \end{pmatrix}, \overrightarrow{v} = \begin{pmatrix} {x_2} \\ {y_2} \end{pmatrix}$.                                       | $\overrightarrow{u} \cdot \overrightarrow{v} = x_1 \times x_2 + y_1 \times y_2$  (Calcul à partir des coordonnées.)                                                                                    | Les coordonnées de $\overrightarrow{u}$ et $\overrightarrow{v}$.                                                                            |
| $\theta$ est l'angle orienté entre $\overrightarrow{u}$ et $\overrightarrow{v}$.                                                                                              | $\overrightarrow{u} \cdot \overrightarrow{v} = \|\|\overrightarrow{u}\|\| \times \|\|\overrightarrow{v}\|\| \times \cos(\theta)$  (Calcul à partir des normes et d'un angle.)                          | La norme de $\overrightarrow{u}$, la norme de $\overrightarrow{v}$ et l'angle $\theta$ entre les deux vecteurs.                             |
| $A$ et $B$ sont les deux extrémités de $\overrightarrow{u}$, $A$ et $C$ sont les deux extrémités de $\overrightarrow{v}$, et $P$ est le projeté orthogonal de $C$ sur $(AB)$. | $\overrightarrow{u} \cdot \overrightarrow{v} = \overrightarrow{AB} \cdot \overrightarrow{AC} = \pm AB \times AP$ $+$ si $P \in [AB)$ et $-$ sinon.  (Calcul à partir d'une projection orthogonale.)   | 3 points distincts (qui sont ici $A$, $B$ et $C$).                                                                                          |
|                                                                                                                                                                               | $\displaystyle{\overrightarrow{u} \cdot \overrightarrow{v} = \frac{\|\|\overrightarrow{u + v}\|\|^2 + \|\|\overrightarrow{u}\|\|^2 + \|\|\overrightarrow{v}\|\|^2}{2}}$  (Calcul à partir des normes.) | On possède la norme de $\overrightarrow{u}$, celle de $\overrightarrow{v}$ mais surtout celle de $\overrightarrow{u} + \overrightarrow{v}$. |

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

<bubble variant="proof">

#### Théorème d'Al-Kashi

En reprenant les notations de l'énoncé :

$c^2$

$= ||\overrightarrow{AB}||^2$

$= ||\overrightarrow{CB} - \overrightarrow{CA}||^2$ (par la relation de Chasles)

$= ||\overrightarrow{CB}||^2 - 2(\overrightarrow{CB} \cdot \overrightarrow{CA}) + ||\overrightarrow{CA}||^2$ (par la
formule de polarisation)

$= CB^2 - 2(CB \times CA \times \cos(\widehat{ACB})) + CA^2$

$= a^2 + b^2 - 2 \times a \times b \times \cos(\widehat{ACB})$

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

<bubble variant="tip">

Il est très facile de dire si oui ou non un point appartient à une droite si l'on possède l'équation cartésienne de
cette droite.

Par exemple, on définit la droite $\mathcal{D}$ par l'équation $y = x - 1$.

Est-ce-que $A = (0; 1)$ appartient à $\mathcal{D}$ ? Remplaçons $x$ et $y$ par les coordonnées de $A$ : $1 = -1$ : c'est
faux donc $A$ n'appartient pas à $\mathcal{D}$ car les coordonnées de $A$ ne vérifient par l'équation cartésienne de
$\mathcal{D}$.

Est-ce-que $B = (4; 3)$ appartient à $\mathcal{D}$ ? Remplaçons $x$ et $y$ par les coordonnées de $B$ : $3 = 3$ : c'est
vrai donc $B$ appartient à $\mathcal{D}$ car les coordonnées de $B$ vérifient l'équation cartésienne de $\mathcal{D}$.

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

<bubble variant="tip">

#### Exemple

Soit $\mathcal{D}$ la droite définie par l'équation $y = 2x + 1$, montrons que $\overrightarrow{v} = \begin{pmatrix} 2
\\ 4\end{pmatrix}$ est un vecteur directeur de $\mathcal{D}$.

Prenons deux points au hasard situés sur cette droite :

$x = 0$ donne $y = 1$, donc le point $A = (0; 1)$ appartient à $\mathcal{D}$.

$x = 1$ donne $y = 3$, donc le point $B = (1; 3)$ appartient à $\mathcal{D}$.

Ainsi, un vecteur directeur de $\mathcal{D}$ est $\overrightarrow{u} = \overrightarrow{AB} = \begin{pmatrix} 1-0 \\
3-1\end{pmatrix} = \begin{pmatrix} 1 \\ 2\end{pmatrix}$.

Il reste à vérifier que $\overrightarrow{u}$ et $\overrightarrow{v}$ sont bien colinéaires, pour cela on peut utiliser
la formule vue en seconde :

$2 \times 2 - 1 \times 4 = 0$ : $\overrightarrow{u}$ et $\overrightarrow{v}$ sont bien colinéaires et donc
$\overrightarrow{v}$ est un vecteur directeur de $\mathcal{D}$.

</bubble>

Il est facile de trouver un vecteur directeur d'une droite dont on connaît l'équation cartésienne.

<bubble variant="formula">

#### Coordonnées d'un vecteur directeur

Soit $\mathcal{D}$ une droite définie par l'équation $ax + by + c = 0$. Alors $\overrightarrow{u} = \begin{pmatrix} -b
\\ a\end{pmatrix}$ est un vecteur directeur de $\mathcal{D}$.

</bubble>

<bubble variant="tip">

#### Exemple

Déterminons l'équation cartésienne de la droite $\mathcal{D}$ de vecteur directeur $\overrightarrow{u} = \begin{pmatrix}
1 \\ 2\end{pmatrix}$ et passant par $A = (1; 0)$.

On a déjà $a$ et $b$ par la propriété précédente :

$-b = 1 \iff b = -1$

$a = 2$

Une équation cartésienne de la droite est $2x - y + c = 0$. Il reste à trouver $c$. Mais comme $\mathcal{D}$ passe par
$A$, les coordonnées de $A$ vérifient l'équation cartésienne de $\mathcal{D}$.

Remplaçons $x$ et $y$ par les coordonnées de $A$ dans l'équation cartésienne : $2 + c = 0 \iff c = -2$.

L'équation cartésienne recherchée est donc $2x - y - 2 = 0$ ou encore $y = 2x - 2$.

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
$\overrightarrow{n}$ sont orthogonaux entre-eux.

</bubble>

<representation geogebra-id="ydshrp8y"></representation>

De plus, on a la propriété suivante qui peut s'avérer très utile :

<bubble variant="formula">

#### Colinéarité des vecteurs normaux

$\overrightarrow{m}$ est un vecteur normal à $\mathcal{D}$ si et seulement s'il est colinéaire au vecteur
$\overrightarrow{n}$ précédent.

</bubble>

Tous les vecteurs normaux d'une droite sont donc colinéaires entre-eux.

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

<bubble variant="tip">

#### Exemple

Déterminons l'équation cartésienne de la droite $\mathcal{D}$ admettant pour vecteur normal $\overrightarrow{n} =
\begin{pmatrix} -1 \\ -1\end{pmatrix}$ et passant par l'origine $O = (0; 0)$.

On a déjà $a$ et $b$ par la propriété précédente :

$a = -1$

$b = -1$

Une équation cartésienne de la droite est $-x - y + c = 0$. Il reste à trouver $c$. Mais comme $\mathcal{D}$ passe par
l'origine, les coordonnées de $O$ vérifient l'équation cartésienne de $\mathcal{D}$.

Remplaçons $x$ et $y$ par les coordonnées de $O$ dans l'équation cartésienne : $c = 0$.

L'équation cartésienne recherchée est donc $-x - y = 0$ ou encore $y = -x$.

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

<bubble variant="proof">

#### Description par produit scalaire

On pose $A = (x_A; y_A)$, $B = (x_B; y_B)$ et on cherche les points $M = (x; y)$ tels que $\overrightarrow{MA} \cdot
\overrightarrow{MB} = 0$.

Soit $O$ le milieu de $[AB]$ :

$\overrightarrow{MA} \cdot \overrightarrow{MB} = 0$

$\iff (\overrightarrow{MO} + \overrightarrow{OA}) \cdot (\overrightarrow{MO} + \overrightarrow{OB}) = 0$

$\iff (\overrightarrow{MO} + \overrightarrow{OA}) \cdot (\overrightarrow{MO} - \overrightarrow{OA}) = 0$

$\iff (\overrightarrow{MO} \cdot \overrightarrow{MO}) - (\overrightarrow{OA} \cdot \overrightarrow{OA}) = 0$

$\iff MO^2 - OA^2 = 0$

$\iff MO = OA$

Donc l'ensemble cherché est l'ensemble des points situés à une distance $OA$ du point $O$, c'est bien le cercle de
centre $O$ et de diamètre $[AB]$.

</bubble>

En réalité, les deux points précédents sont deux manières différentes de décrire un cercle.
