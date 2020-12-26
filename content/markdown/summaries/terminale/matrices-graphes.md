## Matrices

### Définition

<bubble variant="formula">

#### Définition

Soient $m$ et $n$ deux entiers non nuls. Une **matrice réelle** $A$ de taille $m \times n$ est un tableau de réels tel
que :

$\displaystyle{A = \begin{pmatrix}a_{1,1} & a_{1,2} & \dots & a_{1,n} \\ a_{2,1} & a_{2,2} & \dots & a_{2,n} \\ \vdots &
\vdots & \ddots & \vdots \\ a_{m,1} & a_{m,2} & \dots & a_{m,n}\end{pmatrix}}$

Où $a_{1,1}$, $a_{1,2}$, $a_{2,1}$, ..., $a_{m,n}$ sont les **coefficients** de la matrice. L'ensemble des matrices à
coefficients réels est noté $\mathcal{M}_{m,n}(\mathbb{R})$.

</bubble>

Il serait également possible de prendre des matrices à coefficients entiers ou même complexes, mais nous nous limiterons
ici au cas des matrices réelles.

<bubble variant="formula">

#### Types de matrices

Selon leur taille, on peut avoir différents types de matrices :

* Une matrice $1 \times n$ est une **matrice ligne de taille $n$**.
* Une matrice $m \times 1$ est une **matrice colonne de taille $m$**.
* Une matrice $n \times n$ est une **matrice carrée d'ordre $n$**. L'ensemble de ces matrices est noté $\mathcal{M}_n(
  \mathbb{R})$.
* Une matrice $1 \times 1$ est un **réel**.
* La matrice $m \times n$ dont tous les termes sont nuls est la **matrice nulle** et est notée $0_{\mathcal{M}_{m,n}(
  \mathbb{R})}$ (ou plus simplement $0_{m,n}$).

</bubble>

### Types de matrices carrées

<bubble variant="formula">

#### Types de matrices carrées

Il existe différentes matrices carrées remarquables :

* Une matrice carrée dont tous les coefficients en dessous de la diagonale principale sont nuls est une **matrice
  triangulaire supérieure**.
* Une matrice triangulaire supérieure dont les coefficients sur la diagonale sont nuls est une **matrice triangulaire
  supérieure stricte**.
* Une matrice carrée dont tous les coefficients au-dessus de la diagonale principale sont nuls est une **matrice
  triangulaire inférieure**.
* Une matrice triangulaire inférieure dont les coefficients sur la diagonale sont nuls est une **matrice triangulaire
  inférieure stricte**.
* Une matrice carrée dont tous les coefficients qui ne sont pas sur la diagonale sont nuls est une **matrice diagonale**
  .
* Une matrice diagonale dont les coefficients sont égaux à $1$ est une **matrice identité**. Si la taille d'une telle
  matrice est $n$, alors on la note $I_n$.

</bubble>

## Opérations sur les matrices

### Somme

<bubble variant="formula">

#### Somme de deux matrices

Pour additionner deux matrices de même taille, il suffit d'additionner leurs coefficients deux-à-deux. Plus
spécifiquement :

$\displaystyle{\begin{pmatrix}a_{1,1} & a_{1,2} & \dots & a_{1,n} \\ a_{2,1} & a_{2,2} & \dots & a_{2,n} \\ \vdots &
\vdots & \ddots & \vdots \\ a_{m,1} & a_{m,2} & \dots & a_{m,n}\end{pmatrix} + \begin{pmatrix}b_{1,1} & b_{1,2} & \dots
& b_{1,n} \\ b_{2,1} & b_{2,2} & \dots & b_{2,n} \\ \vdots & \vdots & \ddots & \vdots \\ b_{m,1} & b_{m,2} & \dots & b_
{m,n}\end{pmatrix} = \begin{pmatrix}a_{1,1} + b_{1,1} & a_{1,2} + b_{1,2} & \dots & a_{1,n} + b_{1,n} \\ a_{2,1} + b_
{2,1} & a_{2,2} + b_{2,2} & \dots & a_{2,n} + b_{2,n} \\ \vdots & \vdots & \ddots & \vdots \\ a_{m,1} + b_{m,1} & a_
{m,2} + b_{m,2} & \dots & a_{m,n} + b_{m,n}\end{pmatrix}}$

</bubble>

### Produit

<bubble variant="formula">

#### Multiplication d'une matrice par un réel

Soit $\lambda$ un réel. Le produit d'une matrice par $\lambda$ est la matrice de même taille dont les coefficients sont
tous multipliés par $\lambda$. Plus spécifiquement :

$\displaystyle{\lambda \times \begin{pmatrix}a_{1,1} & a_{1,2} & \dots & a_{1,n} \\ a_{2,1} & a_{2,2} & \dots & a_{2,n}
\\ \vdots & \vdots & \ddots & \vdots \\ a_{m,1} & a_{m,2} & \dots & a_{m,n}\end{pmatrix} = \begin{pmatrix}\lambda \times
a_{1,1} & \lambda \times a_{1,2} & \dots & \lambda \times a_{1,n} \\ \lambda \times a_{2,1} & \lambda \times a_{2,2} &
\dots & \lambda \times a_{2,n} \\ \vdots & \vdots & \ddots & \vdots \\ \lambda \times a_{m,1} & \lambda \times a_{m,2} &
\dots & \lambda \times a_{m,n}\end{pmatrix}}$

Si $A$ est la matrice de gauche, on note $\lambda A$ la matrice de droite.

</bubble>

<bubble variant="formula">

#### Produit d'une matrice ligne et d'une matrice colonne

Soient $L = \begin{pmatrix}l_1 & ... & l_n\end{pmatrix}$ une matrice ligne de taille $n$ et $C = \begin{pmatrix}c_1 \\
\vdots \\ c_n\end{pmatrix}$ une matrice colonne de taille $n$.

Le produit de ces deux matrices (noté $LC$) est le réel $LC = l_1 \times c_1 + \dots + l_n \times c_n$.

</bubble>

Plus généralement, le produit matriciel ne se limite pas qu'à la multiplication d'une matrice ligne avec une matrice
colonne.

<bubble variant="formula">

#### Produit de deux matrices

Soient $A$ une matrice de taille $m \times n$ et $B$ une matrice de taille $n \times p$ deux matrices. Le produit de ces
deux matrices (notée $A \times B$ ou $AB$) est la matrice de taille $m \times p$ dont le coefficient à la position $(i;
j)$ est égal au produit de la $i$-ième ligne de $A$ par la $j$-ième colonne de $B$. Plus spécifiquement, en notant $L_i$
la $i$-ème ligne de $A$ et $C_j$ la $j$-ième colonne de $B$ :

$\displaystyle{AB = \begin{pmatrix}c_{1,1} & c_{1,2} & \dots & c_{1,p} \\ c_{2,1} & c_{2,2} & \dots & c_{2,p} \\ \vdots
& \vdots & \ddots & \vdots \\ c_{m,1} & c_{m,2} & \dots & c_{m,p}\end{pmatrix}}$ où $c_{i,j} = L_i \times C_j$.

</bubble>

<bubble variant="formula">

#### Propriétés du produit matriciel

Soient $A$, $B$ et $C$ trois matrices carrées d'ordre $n$. Alors :

* Le produit matriciel est **associatif** : $A(BC) = (AB)C$.
* Le produit matriciel est **distributif** : $A(B + C) = AB + AC$.
* $I_n$ est l'**unité** de $\mathbb{M}_{n}(\mathbb{R})$ : $AI_n = I_nA = A$.
* $0_n$ est le **zéro** de $\mathbb{M}_{n}(\mathbb{R})$ : $A0_n = 0_nA = 0_n$ et $A + 0_n = A$.
* Pour tout $\lambda \in \mathbb{R}$, $\lambda (AB) = (\lambda A)B = A(\lambda B)$.

</bubble>

Cela peut sembler logique, mais on signale tout de même que les priorités les opératoires sont les mêmes que dans les
ensembles de nombres comme $\mathbb{R}$ ou $\mathbb{C}$ (la multiplication prime sur l'addition, etc.).

### Inverse et déterminant

<bubble variant="formula">

#### Inverse d'une matrice

Soit $A$ une matrice carrée d'ordre $n$. $A$ est dite inversible s'il existe une matrice $A^{-1}$ telle que $A \times
A^{-1} = I_n$.

Si cette matrice existe, elle est unique et s'appelle **inverse** de $A$. De plus, $A$ et $A^{-1}$ commutent.

</bubble>

Le **déterminant** permet, entre autres, de calculer l'inverse d'une matrice (s'il existe). Nous nous limiterons ici au
cas des matrices carrées d'ordre $2$, mais il est possible de le généraliser encore plus.

<bubble variant="formula">

#### Déterminant d'une matrice $2 \times 2$

Soit $\displaystyle{A = \begin{pmatrix} a & b \\ c & d \end{pmatrix}}$ une matrice carrée d'ordre $2$.

Alors le déterminant de $A$ (noté $\det(A)$) est le réel $\det(A) = ac - bd$. De plus, $A$ est inversible si et
seulement si $\det(A) \neq 0$.

</bubble>

<bubble variant="formula">

#### Inverse d'une matrice $2 \times 2$

Soit $\displaystyle{A = \begin{pmatrix} a & b \\ c & d \end{pmatrix}}$ une matrice carrée d'ordre $2$ dont le
déterminant ne s'annule pas.

Alors $\displaystyle{A^{-1} = \frac{1}{\det(A)} \begin{pmatrix} d & -b \\ -c & a \end{pmatrix}}$.

</bubble>

### Puissance

<bubble variant="formula">

#### Puissance d'une matrice carrée

Soient $A$ une matrice carrée d'ordre $n$ et $i$ un entier naturel :

* Si $i \gt 0$, $\displaystyle{A^i = \underbrace{A \times \dots \times A}_{i \text{ fois}} = A^{i-1} \times A}$.
* Si $i = 0$, $A^i = A^0 = I_n$.
* Si $i \lt 0$, $\displaystyle{A^i = \underbrace{A^{-1} \times \dots \times A^{-1}}_{i \text{ fois}} = A^{i-1} \times
  A^{-1}}$.

De plus, pour tout entier naturel $j$, on a $A^i \times A^j = A^{i+j}$.

</bubble>

### Transposition

<bubble variant="formula">

#### Définition

Soit $A$ une matrice. La **matrice transposée** de $A$ (notée $^tA$) est la matrice dont la $i$-ième ligne correspond à
la $i$-ième colonne de $A$.

</bubble>

## Applications

### Écriture matricielle d'un système d'équations linéaires

<bubble variant="formula">

#### Lien entre système d'équations linéaires et matrices

Soient quatre réels $a$, $b$, $c$ et $d$ et soient deux réels $\alpha$ et $\beta$. Le système d'équations linéaires à
deux inconnues $\displaystyle{(S) : \begin{cases}ax + by = \alpha \\ cx + dy = \beta\end{cases}}$ (d'inconnues $x$ et
$y$) peut s'écrire matriciellement :

$\displaystyle{(S) \iff \underbrace{\begin{pmatrix}a & b \\ c & d\end{pmatrix}}_{= \, A} \underbrace{\begin{pmatrix}x \\
y\end{pmatrix}}_{= \, X} = \underbrace{\begin{pmatrix}\alpha \\ \beta\end{pmatrix}}_{= \, B}}$

</bubble>

<bubble variant="formula">

#### Résolution du système $(S)$

Avec les notations ci-dessus, si $A$ est inversible (voir les paragraphes suivants) alors le système $(S)$ admet une
unique solution $X = A^{-1}B$.

</bubble>

Nous avons travaillé ici avec un système de deux équations, mais il est tout à fait possible de généraliser cette
méthode à plus de deux équations !

### Suites de matrices colonnes

<bubble variant="formula">

Soit $(U_n)$ une suite de matrices colonnes de taille $m$ vérifiant une relation du type $U_{n+1} = A U_n$ pour tout $n
\in \mathbb{N}$ et où $A \in \mathcal{M}_m(\mathbb{R})$.

Alors, pour tout $n \in \mathbb{N}$, $U_n = A^n U_0$.

</bubble>

<bubble variant="formula">

Soit $(V_n)$ une suite de matrices colonnes de taille $m$ vérifiant une relation du type $V_{n+1} = A V_n + B$ pour tout
$n \in \mathbb{N}$ et où $A$, $B \in \mathcal{M}_m(\mathbb{R})$. Supposons qu'il existe une matrice $X \in \mathcal{M}_
m(\mathbb{R})$ telle que $AX + B = X$.

Alors, pour tout $n \in \mathbb{N}$, $U_n = A^n (U_0 - X) + X$.

</bubble>

### Transformations géométriques du plan

Il est possible de faire le lien entre les matrices et certains types de transformations géométriques du plan.

<bubble variant="formula">

On se place dans un repère $(O; \overrightarrow{i}, \overrightarrow{j})$. Soient $A = (x_A; y_A)$ et $B = (x_B; y_B)$
deux points du plan.

* $B$ est l'image de $A$ par la translation de vecteur $\displaystyle{\overrightarrow{u} = \begin{pmatrix} x_
  {\overrightarrow{u}} \\ y_{\overrightarrow{u}} \end{pmatrix}}$ si et seulement si $\displaystyle{\begin{pmatrix} x_B
  \\ y_B \end{pmatrix} = \begin{pmatrix} x_{\overrightarrow{u}} \\ y_{\overrightarrow{u}} \end{pmatrix} +
  \begin{pmatrix} x_A \\ y_A \end{pmatrix}}$.
* $B$ est l'image de $A$ par la rotation de centre $O$ et d'angle $\theta \in \mathbb{R}$ si et seulement si
  $\displaystyle{\begin{pmatrix} x_B \\ y_B \end{pmatrix} = \begin{pmatrix} \cos(\theta) & -\sin(\theta) \\ \sin(\theta)
  & \cos(\theta) \end{pmatrix} \begin{pmatrix} x_A \\ y_A \end{pmatrix}}$.

</bubble>

## Graphes

### Graphes non-orientés et orientés

<bubble variant="formula">

#### Graphe non-orienté

Un **graphe $G$ non-orienté** est un couple $(S; A)$ où :

* $S$ est l'ensemble des **sommets** de $G$.
* $A$ est un ensemble contenant les éléments de la forme $\{s_i; s_j\}$ où $s_i$, $s_j \in S$, et correspond aux **
  arêtes** de $G$.

</bubble>

<bubble variant="formula">

#### Graphe orienté

Un **graphe $G$ orienté** est un couple $(S; A)$ où :

* $S$ est l'ensemble des **sommets** de $G$.
* $A$ est un sous-ensemble de $S \times S$, et correspond aux **arêtes orientées** de $G$.

</bubble>

<bubble variant="formula">

#### Définition

Soit $G = (S; A)$ un graphe. Donnons quelques définitions nécessaires pour la suite :

* **L'ordre de $G$** est le nombre de sommets que possède $G$ (i.e. le cardinal de $S$).
* **Le degré** d'un sommet est le nombre d'arêtes qui passent par ce sommet (quelque-soit le sens de l'arête dans le cas
  où $G$ est orienté). Les boucles comptent pour $2$.
* Un sommet $A$ est **adjacent** à un autre sommet $B$ s'il existe une arête reliant $A$ à $B$ (i.e. si $(A; B) \in A$
  dans le cas où $G$ est orienté / si $(A; B)$ ou $(B; A) \in A$ si $G$ n'est pas orienté). Si $A$ n'est adjacent à
  aucun autre sommet, alors $A$ est un sommet **isolé**.
* $G$ est dit **complet** si tout sommet de $A$ est adjacent à chacun des autres.

</bubble>

<bubble variant="formula">

Soit $G$ un graphe. On note par $a$ son nombre d'arêtes, et par $d$ la somme des degrés de ses sommets. Alors $d = 2a$.

</bubble>

### Chaînes et chemins

<bubble variant="formula">

#### Définition

Soit $G$ un graphe non-orienté. On appelle **chaîne de taille $n$**, toute succession de $n$ arêtes de $G$ telle que
l'extrémité de chacune est l'origine de la suivante.

Si $G$ est un graphe orienté, on parle de **chemin** plutôt que de chaîne.

</bubble>

<bubble variant="formula">

#### Définition

Dans un graphe $G$ non-orienté :

* Si l'origine d'une chaîne coïncide avec sa fin, on parle de **chaîne fermée** (ou de **chemin fermé** si $G$ est
  orienté).
* Si la chaîne est composée d'arêtes toutes distinctes, on parle de **cycle** (ou de **circuit** si $G$ est orienté).

</bubble>

### Matrices d'adjacence

Le but de cette section est d'étudier le lien étroit qui relie les matrices et les graphes.

<bubble variant="formula">

#### Définition

Soit $G = (S; A)$ un graphe d'ordre $n$. On note $S = \{s_1, \dots, s_n\}$ l'ensemble des sommets de $G$.

On fait correspondre à $G$ la matrice carrée d'ordre $n$ dont le coefficient à la ligne $i$ et la colonne $j$ est égal
au nombre d'arêtes reliant le sommet $s_i$ au sommet $s_j$. Cette matrice est appelée **matrice d'adjacence** du graphe
$G$.

</bubble>

On notera qu'une telle matrice est **symétrique** (par rapport à sa diagonale) si le graphe en question est non-orienté.

<bubble variant="formula">

#### Nombre de chemins de longueur $k$

Soient $G = (S; A)$ un graphe orienté d'ordre $n$ et $M$ sa matrice d'adjacence. On note $S = \{s_1, \dots, s_n\}$
l'ensemble des sommets de $G$.

Alors le coefficient à la ligne $i$ et à la colonne $j$ de $M^k$ est le nombre de chemins de longueur $k$ reliant le
sommet $s_i$ au sommet $s_j$.

</bubble>
