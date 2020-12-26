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

### Orthogonalités

<bubble variant="formula">

#### Définition

Soient $\mathcal{P}$ un plan de l'espace et $\mathcal{D}$ une droite de l'espace. On dit que $\mathcal{D}$ est **
orthogonale** à $\mathcal{P}$ si $\mathcal{D}$ est orthogonale à toutes les droites de ce plan.

</bubble>

### Plan médiateur

<bubble variant="formula">

#### Définition

Soient $\mathcal{P}$ un plan de l'espace, $A$ et $B$ deux points de l'espace.

$\mathcal{P}$ est un **plan médiateur** si $\mathcal{P}$ est orthogonal au segment $[AB]$ et passe par le milieu de ce
segment.

</bubble>
