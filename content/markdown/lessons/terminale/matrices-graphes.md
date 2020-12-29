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

<bubble variant="tip">

#### Diagonale d'une matrice carrée

La diagonale d'une matrice carrée d'ordre $n$ représente l'ensemble des coefficients $a_{i,i}$ où $i$ varie de $1$ à
$n$.

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

<bubble variant="tip">

#### Attention !

Il n'est possible d'additionner que deux matrices de même taille.

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

<bubble variant="tip">

#### Soustraction de deux matrices

Pour soustraire deux matrices $A$ et $B$, on additionne $A$ et $(-1)B$ i.e. $A - B = A + (-1)B$.

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

<bubble variant="tip">

#### Attention !

Le produit matriciel n'est pas commutatif ! Donc en général, $AB \neq BA$.

De plus, il faut bien s'assurer que le nombre de lignes de $A$ est égal au nombre de colonnes de $B$.

</bubble>

<bubble variant="tip">

Si $A$ et $B$ sont deux matrices diagonales de taille $n$. Leur produit est la matrice diagonale de même taille dont le
coefficient à la position $(i; i)$ est le produit du coefficient de $A$ à la position $(i;i)$ par celui du coefficient
de $B$ à la position $(i;i)$. Plus spécifiquement, en notant $A = (a_{i,j})$ et $B = (b_{i,j})$ :

$\displaystyle{\begin{pmatrix}a_{1,1} & 0 & \dots & 0 \\ 0 & a_{2,2} & \dots & 0 \\ \vdots & \vdots & \ddots & \vdots \\
0 & 0 & \dots & a_{n,n}\end{pmatrix} \times \begin{pmatrix}b_{1,1} & 0 & \dots & 0 \\ 0 & b_{2,2} & \dots & 0 \\ \vdots
& \vdots & \ddots & \vdots \\ 0 & 0 & \dots & b_{n,n}\end{pmatrix} = \begin{pmatrix}a_{1,1} \times b_{1,1} & 0 & \dots &
0 \\ 0 & a_{2,2} \times b_{2,2} & \dots & 0 \\ \vdots & \vdots & \ddots & \vdots \\ 0 & 0 & \dots & a_{n,n} \times b_
{n,n}\end{pmatrix}}$

De plus, on a $AB = BA$.

</bubble>

<bubble variant="formula">

#### Propriétés du produit matriciel

Soient $A$, $B$ et $C$ trois matrices carrées d'ordre $n$. Alors :

* Le produit matriciel est **associatif** : $A(BC) = (AB)C$.
* Le produit matriciel est **distributif** : $A(B + C) = AB + AC$.
* $I_n$ est l'**unité** de $\mathcal{M}_{n}(\mathbb{R})$ : $AI_n = I_nA = A$.
* $0_n$ est le **zéro** de $\mathcal{M}_{n}(\mathbb{R})$ : $A0_n = 0_nA = 0_n$ et $A + 0_n = A$.
* Pour tout $\lambda \in \mathbb{R}$, $\lambda (AB) = (\lambda A)B = A(\lambda B)$.

</bubble>

<bubble variant="tip">

#### Attention !

Si on a une égalité du type $A \times B = 0$, cela n'implique pas forcément que $A = 0$ ou $B = 0$ !

De plus, si on a $AB = AC$, on n'a pas forcément $B = C$.

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

<bubble variant="tip">

#### Exemple

Calculons le produit de $\displaystyle{A = \begin{pmatrix}2 & 1 \\ 6 & 4\end{pmatrix}}$ par $\displaystyle{B =
\begin{pmatrix}4 & -1 \\ -6 & 2\end{pmatrix}}$, et déduisons-en que $A$ est inversible sans utiliser la formule donnée
précédemment.

Le produit nous donnera une matrice carrée d'ordre $2$ car on multiplie deux matrices carrées d'ordre $2$ :

$\displaystyle{\begin{pmatrix} 2 & 1 \\ 6 & 4 \end{pmatrix} \times \begin{pmatrix} 4 & -1 \\ -6 & 2\end{pmatrix} =
\begin{pmatrix}8-6 & -2+2 \\ 24-24 & -6+8 \end{pmatrix} = \begin{pmatrix} 2 & 0 \\ 0 & 2 \end{pmatrix}}$

Donc $A \times B = 2I_2$. Ainsi, $A$ est inversible et $A^{-1} = \frac{1}{2} B$.

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

<bubble variant="tip">

#### Puissance d'une matrice diagonale

Si $A$ est une matrice diagonale, alors $A^i$ est la matrice de même taille où tous les termes de la diagonale sont mis
à la puissance $i$ (cela vaut aussi si $i$ est négatif et que la diagonale ne comporte pas de $0$).

</bubble>

### Transposition

<bubble variant="formula">

#### Définition

Soit $A$ une matrice. La **matrice transposée** de $A$ (notée $^tA$) est la matrice dont la $i$-ième ligne correspond à
la $i$-ième colonne de $A$.

</bubble>

<bubble variant="tip">

#### Exemple

Soient $\displaystyle{A = \begin{pmatrix} 2 & 5 & 9 \\ 3 & 6 & 10 \end{pmatrix}}$ et $\displaystyle{B = \begin{pmatrix}
0 & 1 & 1 \\ 2 & 3 & 5 \\ 8 & 13 & 21 \end{pmatrix}}$. Calculons $^tA$ et $^tB$.

On a $\displaystyle{^tA = \begin{pmatrix} 2 & 3 \\ 5 & 6 \\ 9 & 10 \end{pmatrix}}$ et $\displaystyle{^tB =
\begin{pmatrix} 0 & 2 & 8 \\ 1 & 3 & 13 \\ 1 & 5 & 21 \end{pmatrix}}$.

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

<bubble variant="tip">

#### Exemple

Cela peut sembler compliqué à appliquer, mais il n'en est rien !

Par exemple, transformons le système $\displaystyle{(S) : \begin{cases}x + 2y = 1 \\ 2x + 5y = 4 \end{cases}}$ en une
égalité de matrices :

$\displaystyle{(S) \iff \begin{pmatrix}1 & 2 \\ 2 & 5\end{pmatrix} \begin{pmatrix}x \\ y\end{pmatrix} = \begin{pmatrix}1
\\ 4 \end{pmatrix}}$

Or l'inverse de $\displaystyle{\begin{pmatrix}1 & 2 \\ 2 & 5\end{pmatrix}}$ est $\displaystyle{\begin{pmatrix}5 & -2 \\
-2 & 1\end{pmatrix}}$. D'où $\displaystyle{\begin{pmatrix}x \\ y\end{pmatrix} = \begin{pmatrix}5 & -2 \\ -2 &
1\end{pmatrix} \begin{pmatrix}1 \\ 4\end{pmatrix} = \begin{pmatrix}-3 \\ 2\end{pmatrix}}$.

Or deux matrices sont égales si et seulement si leurs coefficients sont tous égaux. Donc on a $x = -3$ et $y = 2$.

</bubble>

Nous avons travaillé ici avec un système de deux équations, mais il est tout à fait possible de généraliser cette
méthode à plus de deux équations !

### Suites de matrices colonnes

<bubble variant="formula">

Soit $(U_n)$ une suite de matrices colonnes de taille $m$ vérifiant une relation du type $U_{n+1} = A U_n$ pour tout $n
\in \mathbb{N}$ et où $A \in \mathcal{M}_m(\mathbb{R})$.

Alors, pour tout $n \in \mathbb{N}$, $U_n = A^n U_0$.

</bubble>

<bubble variant="tip">

Il peut sembler étrange de manipuler des suites de matrices, mais c'est en réalité très intuitif. Par exemple,
définissions la suite $(U_n)$ par $\displaystyle{U_0 = \begin{pmatrix} 1 \\ 2 \end{pmatrix}}$ et pour tout $n \geq 1$
par $\displaystyle{U_{n+1} = \underbrace{\begin{pmatrix} 1 & 0 \\ 0 & 2 \end{pmatrix}}_{= A} U_n}$ et cherchons son
terme général.

Par la formule précédente, pour tout $n \in \mathbb{N}$, $U_n = A^n U_0$. Or, $A$ est une matrice diagonale, donc
$\displaystyle{A^n = \begin{pmatrix} 1^n & 0 \\ 0 & 2^n \end{pmatrix}}$, et ainsi :

$\displaystyle{U_n = \begin{pmatrix} 1 & 0 \\ 0 & 2^n \end{pmatrix} \begin{pmatrix} 1 \\ 2 \end{pmatrix} =
\begin{pmatrix} 1 \\ 2^{n+1} \end{pmatrix}}$

On remarque en particulier que la suite $(U_n)$ est divergente (à cause de sa deuxième coordonnée qui tend vers
$+\infty$).

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

<bubble variant="tip">

#### Exemple

On pose $A = (1; 1)$. Calculons les coordonnées de $B$ qui est l'image de $A$ par la translation de vecteur
$\displaystyle{\overrightarrow{u} = \begin{pmatrix} -1 \\ -2 \end{pmatrix}}$, et de $C$ qui est l'image de $A$ par la
rotation de centre $O$ et d'angle $\displaystyle{\frac{\pi}{4}}$.

On a :

$\displaystyle{\begin{pmatrix} x_B \\ y_B \end{pmatrix} = \begin{pmatrix} -1 \\ -2 \end{pmatrix} + \begin{pmatrix} 1 \\
1 \end{pmatrix}}$ et $\displaystyle{\begin{pmatrix} x_C \\ y_C \end{pmatrix} = \begin{pmatrix} \frac{\sqrt{2}}{2} &
-\frac{\sqrt{2}}{2} \\ \frac{\sqrt{2}}{2} & \frac{\sqrt{2}}{2} \end{pmatrix} \begin{pmatrix} 1 \\ 1 \end{pmatrix}}$.

Donc $B = (-1; 1)$ et $C = (0; \sqrt{2})$.

<representation geogebra-id="tjwgwr8j"></representation>

</bubble>

## Graphes

### Graphes non-orientés et orientés

<bubble variant="formula">

#### Graphe non-orienté

Un **graphe $G$ non-orienté** est un couple $(S; A)$ où :

* $S$ est l'ensemble des **sommets** de $G$.
* $A$ est un ensemble contenant les éléments de la forme $\{s_i; s_j\}$ où $s_i$, $s_j \in S$, et correspond aux
  **arêtes** de $G$.

</bubble>

<bubble variant="tip">

#### Exemple

Par exemple, $G = (\{A; B; C; D; E\}, \{\{A; B\}; \{B; C\}; \{C; D\}; \{D; A\}; \{D; E\}; \{E; A\}\}$ est un graphe
non-orienté que l'on peut représenter comme tel :

![Graphe 1](/img/lessons/terminale/matrices-graphes/graphe-1.svg)

Signalons tout de même que l'ordre dans lequel on relie les sommets n'a pas d'importance.

</bubble>

<bubble variant="formula">

#### Graphe orienté

Un **graphe $G$ orienté** est un couple $(S; A)$ où :

* $S$ est l'ensemble des **sommets** de $G$.
* $A$ est un sous-ensemble de $S \times S$, et correspond aux **arêtes orientées** de $G$.

</bubble>

<bubble variant="tip">

#### Exemple

Par exemple, $G = (\{A; B; C; D; E\}, \{(A; B); (B; C); (C; D); (D; E); (A; E)\}$ est un graphe orienté que l'on peut
représenter comme tel :

![Graphe 2](/img/lessons/terminale/matrices-graphes/graphe-2.svg)

</bubble>

<bubble variant="tip">

À noter que dans les deux cas, il est possible de relier un sommet à lui-même (en faisant **une boucle**).

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

<bubble variant="tip">

#### Exemple

On considère le graphe orienté $G$ suivant :

![Graphe 3](/img/lessons/terminale/matrices-graphes/graphe-3.svg)

Alors :

* $G$ n'est pas complet.
* L'ordre de $G$ est égal à $5$.
* $G$ a $4$ arêtes (donc la somme des degrés des sommets de $G$ vaut $2 \times 4 = 8$).
* Le degré des sommets $A$ et $B$ est égal à $1$.
* Le degré des sommets $C$, $D$ et $E$ est égal à $2$.
* Le sommet $A$ est adjacent au sommet $E$ (mais $E$ n'est pas adjacent à $A$).
* $C$ est un sommet isolé.
* L'arête orientée qui va de $C$ à $C$ est une boucle.

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

<bubble variant="tip">

#### Exemple

On considère le graphe non-orienté suivant :

![Graphe 4](/img/lessons/terminale/matrices-graphes/graphe-4.svg)

Alors :

* $A-B-C-D-A$ est un chemin fermé de longueur $4$ (c'est même un cycle).
* $A-C-B-D$ est un chemin de longueur $3$ reliant $A$ à $D$ (mais il y en a beaucoup d'autres).

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

<bubble variant="tip">

#### Exemple

On considère le graphe orienté $G_1$ suivant :

![Graphe 5](/img/lessons/terminale/matrices-graphes/graphe-5.svg)

Sa matrice d'adjacence est la matrice $\displaystyle{M_1 = \begin{pmatrix} 0 & 1 & 0 \\ 0 & 0 & 1 \\ 1 & 0 & 0
\end{pmatrix}}$.

</bubble>

<bubble variant="tip">

#### Exemple

On considère le graphe non-orienté $G_2$ suivant (i.e. le même que le $G_1$ mais sans les orientations) :

![Graphe 6](/img/lessons/terminale/matrices-graphes/graphe-6.svg)

Sa matrice d'adjacence est la matrice $\displaystyle{M_2 = \begin{pmatrix} 0 & 1 & 1 \\ 1 & 0 & 1 \\ 1 & 1 & 0
\end{pmatrix}}$.

</bubble>

Remarquons sur ces deux exemples que le caractère orienté ou non d'un graphe change sa matrice d'adjacence !

<bubble variant="formula">

#### Nombre de chemins de longueur $k$

Soient $G = (S; A)$ un graphe orienté d'ordre $n$ et $M$ sa matrice d'adjacence. On note $S = \{s_1, \dots, s_n\}$
l'ensemble des sommets de $G$.

Alors le coefficient à la ligne $i$ et à la colonne $j$ de $M^k$ est le nombre de chemins de longueur $k$ reliant le
sommet $s_i$ au sommet $s_j$.

</bubble>

<bubble variant="proof">

#### Nombre de chemins de longueur $k$

On pose $m_{i,j}^{(k)}$ le coefficient à la ligne $i$ et à la colonne $j$ de $M^k$ et on note $\mathcal{P}_k$ la
propriété définie pour tout $k \geq 1$ par $\mathcal{P}_k$ : $m_{i,j}^{(k)}$ est le nombre de chemins de longueur
$k$ reliant le sommet $s_i$ au sommet $s_j$''. Montrons $\mathcal{P}_n$ par récurrence.

**Initialisation :** On teste la propriété au rang $1$ :

$\mathcal{P}_1$ est vraie car $m_{i,j}^{(1)}$ est égal au nombre d'arêtes (i.e. de chemins de longueur $1$) reliant le
sommet $s_i$ au sommet $s_j$.

**Hérédité :** Supposons la propriété vraie jusqu'à un rang $k \geq 1$ et vérifions qu'elle est vraie au rang $k+1$.

On a $M^{n+1} = M^{n} \times M$. Donc $m_{i,j}^{(k+1)} = m_{i,1}^{(k)}m_{1,j}^{(1)} + m_{i,2}^{(k)}m_{2,j}^{(1)} + \dots
+ m_{i,n}^{(k)}m_{n,j}^{(1)}$.

Or, par hypothèse, pour tout $l \in \{1; \dots; n\}$, $m_{i,l}^{(n)}$ est le nombre de chemins de longueur $n$ reliant
$s_i$ à $s_l$ et $m_{l,j}$ est le nombre d'arêtes reliant le sommet $s_l$ au sommet $s_j$.

Ainsi, $m_{i,l}^{(k)}m_{l,j}^{(1)}$ est le nombre de chemins de longueur $n+1$ passant par $s_l$ et reliant $s_i$ à
$s_j$.

Donc en sommant pour tous les sommets $s_l$, on obtient le nombre de chemins de longueur $n+1$ reliant $s_i$ à $s_j$.
Donc $\mathcal{P}_{n+1}$ est vraie.

**Conclusion :**

La propriété est initialisée au rang $1$ et est héréditaire. Ainsi, $\mathcal{P}_n$ est vraie pour tout $n \geq 1$.

</bubble>
