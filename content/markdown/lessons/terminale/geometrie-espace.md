## Vecteurs de l'espace

### Lien avec la géométrie plane

<bubble variant="formula">

#### Définition

Un **vecteur de l'espace** est un vecteur possédant trois coordonnées. De même, un **point de l'espace** est un point
possédant trois coordonnées.

</bubble>

Comme dans le plan, un vecteur de l'espace est caractérisé par **une norme** (sa longueur), **un sens**, et **une
direction**.

<bubble variant="formula">

#### Opérations sur les vecteurs

Soient $\overrightarrow{u} = \begin{pmatrix} x_1 \\ y_1 \\ z_1 \end{pmatrix}$ et $\overrightarrow{v} = \begin{pmatrix}
x_2 \\ y_2 \\ z_2 \end{pmatrix}$ deux vecteurs de l'espace et $\lambda$ un réel quelconque.

* On peut additionner deux vecteurs : $u + v = \begin{pmatrix} x_1 + x_2 \\ y_1 + y_2 \\ z_1 + z_2 \end{pmatrix}$.
* On peut multiplier un vecteur par un réel : $\lambda u = \begin{pmatrix} \lambda x_1 \\ \lambda y_1 \\ \lambda z_1
  \end{pmatrix}$.

</bubble>

La **relation de Chasles** est également disponible dans l'espace.

<bubble variant="formula">

#### Relation de Chasles

Soient $A$, $B$ et $C$ trois points de l'espace. Alors $\overrightarrow{AC} = \overrightarrow{AB} +
\overrightarrow{BC}$.

</bubble>

### Coplanarité

Soient $\overrightarrow{u}$ et $\overrightarrow{v}$ deux vecteurs non colinéaires de l'espace et $\overrightarrow{w}$ un
autre vecteur de l'espace. Ces vecteurs sont dits **coplanaires** s'il existe des représentants de ces trois vecteurs
dans un même plan. De manière plus formelle :

<bubble variant="formula">

#### Définition

$\overrightarrow{u}$, $\overrightarrow{v}$ et $\overrightarrow{w}$ sont coplanaires s'il existe deux réels $\alpha$ et
$\beta$ tels que $\overrightarrow{w} = \alpha \overrightarrow{u} + \beta \overrightarrow{v}$.

</bubble>

### Repérage dans l'espace

<bubble variant="formula">

#### Repère de l'espace

Soient $\overrightarrow{i}$, $\overrightarrow{j}$ et $\overrightarrow{k}$ trois vecteurs non coplanaires de l'espace et
$O$ un point de l'espace.

Tout point $M$ peut alors être identifié dans ce repère par un unique triplet de réels $(x;y;z)$ tel que :

$\overrightarrow{OM} = x\overrightarrow{i} + y\overrightarrow{j} + z\overrightarrow{k}$.

On dit alors $(O ; \overrightarrow{i} ; \overrightarrow{j} ; \overrightarrow{k})$ est un **repère de l'espace** et
les **coordonnées** de $M$ dans ce repère sont alors $(x; y; z)$. Par abus de langage, on notera cela $M = (x; y; z)$.

</bubble>

<bubble variant="tip">

#### Nom des coordonnées

En reprenant les notations précédentes, $x$ est **l'abscisse**, $y$ est **l'ordonnée** et $z$ est **la côte** de $M$.

</bubble>

Dans toute la suite du chapitre, on se placera dans le repère précédent $(O ; \overrightarrow{i} ; \overrightarrow{j} ;
\overrightarrow{k})$.

<bubble variant="formula">

#### Types de repères

* Le repère est dit **orthogonal** si $\overrightarrow{i}$, $\overrightarrow{j}$ et $\overrightarrow{k}$ sont
  orthogonaux les uns par rapport aux autres.
* Le repère est dit **normé** si $\overrightarrow{i}$, $\overrightarrow{j}$ et $\overrightarrow{k}$ sont de norme $1$.
* Le repère est dit **orthonormé** si les deux conditions précédentes sont réunies.

</bubble>

## Produit scalaire dans l'espace

### Caractérisation

Soient $\overrightarrow{u}$ et $\overrightarrow{v}$ deux vecteurs de l'espace et $A$, $B$ et $C$ trois points de
l'espace. Il existe un plan qui contient les points $A$, $B$ et $C$ tels que $\overrightarrow{u} = \overrightarrow{AB}$
et $\overrightarrow{v} = \overrightarrow{AC}$. Le produit scalaire $\overrightarrow{u} \cdot \overrightarrow{v}$ est
alors égal au produit scalaire $\overrightarrow{AB} \cdot \overrightarrow{AC}$ dans ce plan.

Toutes les propriétés du produit scalaire du plan sont par conséquent également applicables dans l'espace. Il vous est
donc conseillé de relire [le cours de Première](/cours/premiere/geometrie-reperee/) sur le produit scalaire.

### Calcul du produit scalaire

<bubble variant="formula">

#### Calcul avec les coordonnées

Soient $\overrightarrow{u} = \begin{pmatrix} {x_1} \\ {y_1} \\ {z_1} \end{pmatrix}$ et $\overrightarrow{v} =
\begin{pmatrix} {x_2} \\ {y_2} \\ {z_2} \end{pmatrix}$ deux vecteurs de l'espace.

On a $\overrightarrow{u} \cdot \overrightarrow{v} = x_1x_2 + y_1y_2 + z_1z_2$.

</bubble>

<bubble variant="formula">

#### Calcul avec un angle

Soient $\overrightarrow{u}$ et $\overrightarrow{v}$ deux vecteurs du plan et $\theta$ l'angle orienté entre les deux. On
a :

$\overrightarrow{u} \cdot \overrightarrow{v} = ||\overrightarrow{u}|| \times ||\overrightarrow{v}|| \times \cos(\theta)$

</bubble>

<bubble variant="formula">

#### Calcul un projeté orthogonal

Soient $A$, $B$ et $C$ trois points distincts de l'espace. On se place dans le plan défini par ces points. On pose $P$
le projeté orthogonal de $C$ sur $(AB)$. Alors :

* Si $P \in [AB)$ alors $\overrightarrow{AB} \cdot \overrightarrow{AC} = AB \times AP$
* Si $P \notin [AB)$ alors $\overrightarrow{AB} \cdot \overrightarrow{AC} = - AB \times AP$

</bubble>

Si on ne possède que les normes de nos vecteurs, il est possible d'utiliser la formule de polarisation.

<bubble variant="formula">

#### Formule de polarisation

Soient $\overrightarrow{u}$ et $\overrightarrow{v}$ deux vecteurs de l'espace :

$\overrightarrow{u} \cdot \overrightarrow{v} = \displaystyle{\frac{1}{2} \left(||\overrightarrow{u + v}||^2 -
||\overrightarrow{u}||^2 - ||\overrightarrow{v}||^2\right)}$.

</bubble>

<bubble variant="tip">

#### Utilisation des formules

Il faut vraiment trouver la formule à utiliser selon l'énoncé de l'exercice.

Par exemple, si on se trouve dans un repère et que l'on a les coordonnées des vecteurs, on pourra utiliser la formule
analytique (la première formule donnée).

À l'inverse, si on ne possède pas les coordonnées de nos vecteurs mais que l'on possède leur normes, il est possible
d'utiliser la formule de polarisation.

Voici un tableau récapitulatif pour $\overrightarrow{u}$ et $\overrightarrow{v}$ vecteurs de l'espace :

| Paramètres                                                                                                                                                                    | Formule                                                                                                                                                                                                  | À utiliser si on possède...                                                                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| $\overrightarrow{u} = \begin{pmatrix} {x_1} \\ {y_1} \\ {z_1} \end{pmatrix}, \overrightarrow{v} = \begin{pmatrix} {x_2} \\ {y_2} \\ {z_2} \end{pmatrix}$.                     | $\overrightarrow{u} \cdot \overrightarrow{v} = x_1 \times x_2 + y_1 \times y_2 + z_1 \times z_2$  (Calcul à partir des coordonnées.)                                                                     | Les coordonnées de $\overrightarrow{u}$ et $\overrightarrow{v}$.                                                                            |
| $\theta$ est l'angle orienté entre $\overrightarrow{u}$ et $\overrightarrow{v}$.                                                                                              | $\overrightarrow{u} \cdot \overrightarrow{v} = \|\|\overrightarrow{u}\|\| \times \|\|\overrightarrow{v}\|\| \times \cos(\theta)$  (Calcul à partir des normes et d'un angle.)                            | La norme de $\overrightarrow{u}$, la norme de $\overrightarrow{v}$ et l'angle $\theta$ entre les deux vecteurs.                             |
| $A$ et $B$ sont les deux extrémités de $\overrightarrow{u}$, $A$ et $C$ sont les deux extrémités de $\overrightarrow{v}$, et $P$ est le projeté orthogonal de $C$ sur $(AB)$. | $\overrightarrow{u} \cdot \overrightarrow{v} = \overrightarrow{AB} \cdot \overrightarrow{AC} = \pm AB \times AP$ $+$ si $P \in [AB)$ et $-$ sinon.  (Calcul à partir d'une projection orthogonale.)     | 3 points distincts (qui sont ici $A$, $B$ et $C$).                                                                                          |
|                                                                                                                                                                               | & $\displaystyle{\overrightarrow{u} \cdot \overrightarrow{v} = \frac{\|\|\overrightarrow{u + v}\|\|^2 - \|\|\overrightarrow{u}\|\|^2 - \|\|\overrightarrow{v}\|\|^2}{2}}$  (Calcul à partir des normes.) | On possède la norme de $\overrightarrow{u}$, celle de $\overrightarrow{v}$ mais surtout celle de $\overrightarrow{u} + \overrightarrow{v}$. |

</bubble>

## Droites de l'espace

### Définition

Une droite passant par deux points de l'espace différents $A$ et $B$ peut être définie par ces points. Ainsi la droite
de l'espace contenant les points $A$ et $B$ peut se nommer la droite $(AB)$.

### Caractérisation

<bubble variant="formula">

#### Vecteur directeur d'une droite

Le **vecteur directeur** d'une droite de l'espace est le vecteur qui porte (ou qui suit) cette droite.

</bubble>

Plusieurs manières existent pour caractériser une droite de l'espace.

<bubble variant="formula">

#### Caractérisation d'une droite de l'espace

Soit $\mathcal{D}$ une droite de l'espace passant par un point $A = (x_A, y_A, y_C)$ de vecteur directeur
$\overrightarrow{u} = \begin{pmatrix} a \\ b \\ c \end{pmatrix}$.

Soit $M = (x; y; z)$. On peut caractériser $\mathcal{D}$ de deux manières :

* **Caractérisation vectorielle :**  
  $M \in \mathcal{D} \iff \overrightarrow{AM} = \lambda \overrightarrow{u}$ où $\lambda \in \mathbb{R}$.
* **Caractérisation par système d'équations paramétriques :**  
  $M \in \mathcal{D} \iff \text{ il existe } \lambda \in \mathbb{R} \text{ tel que } \begin{cases} x = x_A + \lambda a
  \\ y = y_A + \lambda b \\ z = z_A + \lambda c \end{cases}$.

</bubble>

<bubble variant="tip">

#### Comment déterminer une représentation paramétrique d'une droite ?

On a deux cas : soit on a directement un point $A$ appartenant à la droite ainsi qu'un vecteur directeur de cette
droite. Dans ce cas, il faut appliquer la deuxième formule donnée précédemment (en remplaçant $x_A$, $y_A$ et $z_A$ par
les coordonnées de $A$ et $a$, $b$ et $c$ par les coordonnées du vecteur directeur).

Soit on nous donne deux points de la droite, disons $A$ et $B$. Ce qui signifie que la droite est de vecteur directeur
$\overrightarrow{AB}$ et passe par le point $A$. Encore une fois on utilise la deuxième formule donnée précédemment une
fois le vecteur $\overrightarrow{AB}$ calculé (il suffit alors de remplacer $x_A$, $y_A$ et $z_A$ par les coordonnées de
$A$ et $a$, $b$ et $c$ par les coordonnées de $\overrightarrow{AB}$).

</bubble>

### Intersection de deux droites

<bubble variant="formula">

#### Intersection de deux droites

Soient $\mathcal{D}_1$ et $\mathcal{D}_2$ deux droites. On a les relations suivantes :

* Si $\mathcal{D}_1$ et $\mathcal{D}_2$ ne sont pas coplanaires, leur intersection **est vide**.
* Si $\mathcal{D}_1$ et $\mathcal{D}_2$ sont coplanaires et parallèles mais pas confondues, leur intersection **est
  vide**.
* Si $\mathcal{D}_1$ et $\mathcal{D}_2$ sont coplanaires et confondues, leur intersection **est la droite $\mathcal{D}_
  1$**.
* Si $\mathcal{D}_1$ et $\mathcal{D}_2$ sont coplanaires et non parallèles, leur intersection **est un point**.

</bubble>

### Orthogonalité de deux droites

<bubble variant="formula">

#### Définition

Deux droites $\mathcal{D}_1$ et $\mathcal{D}_2$ sont **orthogonales** s'il existe une parallèle à $\mathcal{D}_1$ qui
est perpendiculaire à $\mathcal{D}_2$.

</bubble>

<bubble variant="tip">

#### Relation avec les vecteurs directeurs

Ainsi, $\mathcal{D}_1$ et $\mathcal{D}_2$ sont orthogonales si un vecteur directeur de $\mathcal{D}_1$ est orthogonal à
un vecteur directeur de $\mathcal{D}_2$ (c'est-à-dire, si leur produit scalaire vaut $0$).

</bubble>

## Plans de l'espace

### Définition

Soient trois points $A$, $B$ et $C$ non alignés (i.e. tels que les vecteurs $\overrightarrow{AB}$ et
$\overrightarrow{AC}$ ne sont pas colinéaires). Alors ces points forment un plan de l'espace qui peut se nommer $(ABC)$.

### Caractérisation

<bubble variant="formula">

#### Vecteur normal à un plan

On dit qu'un vecteur est **normal** à un plan s'il est orthogonal à tous les vecteurs de ce plan.

</bubble>

Plusieurs manières existent pour caractériser un plan de l'espace.

<bubble variant="formula">

#### Caractérisation d'un plan de l'espace

Soit $\mathcal{P}$ un plan de l'espace contenant un point $A$ et soient $\overrightarrow{u}$ et $\overrightarrow{v}$
deux vecteurs de l'espace non-colinéaires mais qui appartiennent à $\mathcal{P}$.

On se donne un vecteur de l'espace $\overrightarrow{n} = \begin{pmatrix} a \\ b \\ c \end{pmatrix}$ orthogonal à
$\overrightarrow{u}$ et $\overrightarrow{v}$ (qui est donc normal à $\mathcal{P}$).

Soit $M = (x; y; z)$. On peut caractériser $\mathcal{P}$ de deux manières :

* **Caractérisation vectorielle :**  
  $M \in \mathcal{P} \iff \text{ il existe } \lambda \text{ et } \mu \in \mathbb{R} \text{ tels que }
  \overrightarrow{AM} = \lambda \overrightarrow{u} + \mu \overrightarrow{v}$.
* **Caractérisation par une équation cartésienne :**  
  Il existe $d \in \mathbb{R}$ tel que $M \in \mathcal{P} \iff ax + by + cz + d = 0$.

</bubble>

<bubble variant="tip">

#### Comment déterminer une équation cartésienne d'un plan ?

Deux cas : soit on a directement un point du plan ainsi qu'un vecteur normal à ce plan. Dans ce cas, on remplace $a$,
$b$ et $c$ par les coordonnées de ce vecteur normal (dans la deuxième formule). Il reste à trouver $d$ et pour cela on
remplace $x$, $y$ et $z$ par les coordonnées du point donné.

Soit on a un point du plan et on précise que le plan doit être perpendiculaire à une droite dont la représentation
paramétrique est donnée. Dans ce cas le vecteur normal au plan sera un vecteur directeur de cette droite et il faudra
encore une fois appliquer la deuxième formule donnée précédemment.

</bubble>

### Intersections

<bubble variant="formula">

#### Intersection d'un plan et d'une droite

Soient $\mathcal{P}$ un plan de l'espace et $\mathcal{D}$ une droite de l'espace :

* Si $\mathcal{P}$ contient $\mathcal{D}$, leur intersection **est la droite $\mathcal{D}$**.
* Si $\mathcal{P}$ ne contient pas $\mathcal{D}$ et que $\mathcal{P}$ et $\mathcal{D}$ sont parallèles, leur
  intersection **est vide**.
* Si $\mathcal{P}$ ne contient pas $\mathcal{D}$ et que $\mathcal{P}$ et $\mathcal{D}$ ne sont pas parallèles, leur
  intersection **est un point**.

</bubble>

<bubble variant="formula">

#### Intersection de deux plans

Soient $\mathcal{P}_1$ et $\mathcal{P}_2$ deux plans de l'espace :

* Si $\mathcal{P}_1$ et $\mathcal{P}_2$ sont confondus, leur intersection **est le plan $\mathcal{P}_1$**.
* Si $\mathcal{P}_1$ et $\mathcal{P}_2$ sont parallèles mais pas confondus, leur intersection **est vide**.
* Si $\mathcal{P}_1$ et $\mathcal{P}_2$ ne sont ni parallèles ni confondus, leur intersection **est une droite**.

</bubble>

<bubble variant="tip">

#### Intersection de trois plans

L'intersection de trois plans de l'espace peut soit être **vide**, soit être **une droite**, soit être **un point**.

</bubble>

### Orthogonalités

<bubble variant="formula">

#### Définition

Soient $\mathcal{P}$ un plan de l'espace et $\mathcal{D}$ une droite de l'espace. On dit que $\mathcal{D}$ est
**orthogonale** à $\mathcal{P}$ si $\mathcal{D}$ est orthogonale à toutes les droites de ce plan.

</bubble>

<bubble variant="tip">

#### Relation avec les vecteurs directeurs

Ainsi, $\mathcal{D}$ et $\mathcal{P}$ sont orthogonaux si un vecteur directeur de $\mathcal{D}$ est normal à
$\mathcal{P}$.

</bubble>

<bubble variant="tip">

#### Propriétés

Plusieurs propriétés découlent de ceci :

* Si deux plans sont parallèles, alors toute droite orthogonale à l'un est orthogonale à l'autre.
* Si deux plans sont orthogonaux à une même droite, alors ils sont alors parallèles.
* Pour montrer qu'une droite est orthogonale à un plan, il suffit de montrer que cette droite est orthogonale à deux
  droites de ce plan.
* Si deux droites sont parallèles, tout plan orthogonal à l'une est orthogonal à l'autre.
* Si deux droites sont orthogonales à un même plan, alors elles sont parallèles entre elles.

</bubble>

### Plan médiateur

<bubble variant="formula">

#### Définition

Soient $\mathcal{P}$ un plan de l'espace, $A$ et $B$ deux points de l'espace.

$\mathcal{P}$ est un **plan médiateur** si $\mathcal{P}$ est orthogonal au segment $[AB]$ et passe par le milieu de ce
segment.

</bubble>
