## Définitions

### Ensemble d'éléments

Cette partie donne quelques rappels sur la notion d'ensemble en mathématiques.

<bubble variant="formula">

#### Définition

Un **ensemble** $E$ désigne une collection finie ou infinie d'objets distincts qu'on appelle ses **éléments**.

On note $x \in E$ si l'objet $x$ appartient à $E$. Dans le cas contraire, on note $x \notin E$.

</bubble>

À noter que l'ordre des objets n'a aucune importance lorsque l'on compare deux ensembles.

<bubble variant="tip">

#### Exemple

Voici quelques exemples d'ensembles :

* $\{2; 4; 6\}$ est un ensemble contenant $3$ éléments.
* $\mathbb{Z}$ et $\mathbb{R}$ sont deux ensembles contenant une infinité d'éléments.
* $\{\}$ est un ensemble ne contenant aucun élément : c'est **l'ensemble vide**, noté $\emptyset$.
* $\{1\}$ est un ensemble content $1$ élément : c'est un **singleton**.

</bubble>

<bubble variant="tip">

Il est possible de créer des ensembles contenant autre choses que des nombres. Par exemple, on définit les fonctions
$f : x \mapsto x^2$ et $g : x \mapsto x^3 + 1$. Alors l'ensemble $E = \{f; g\}$ est un ensemble contenant des fonctions.

</bubble>

<bubble variant="formula">

#### Réunion et intersection

Soient $E$ et $F$ deux ensembles.

* Leur **réunion** notée $E \, \cup \, F$ est l'ensemble constitué des éléments de $E$ et des éléments de $F$.
* Leur **intersection** notée $E \, \cap \, F$ est l'ensemble constitué des éléments communs à $E$ et $F$.
* Si $E \, \cap \, F = \emptyset$, on dit que $E$ et $F$ sont **disjoints**.

</bubble>

### Sous-ensemble

<bubble variant="formula">

#### Définition

Soient $E$ et $F$ deux ensembles. On dit que $F$ est un **sous-ensemble** (ou une partie) de $E$ si tout élément de $F$
est un élément de $E$.

On note ceci par $F \subset E$ (qui signifie $F$ est inclus dans $E$).

</bubble>

<bubble variant="tip">

#### Exemple

Soient $E$ et $F$ deux ensembles. Alors $E \, \cap \, F \subset E$ et $E \, \cap \, F \subset F$.

</bubble>

### Liste d'éléments

Nous allons désormais voir un type de collection similaire aux ensembles, mais qui prend en compte l'ordre des éléments.

<bubble variant="formula">

#### Définition

Un **$p$-uplet** (ou une $p$-liste) d'un ensemble $E$ désigne une collection ordonnée de $p$ éléments de $E$.

</bubble>

Remarquons que l'on ne demande pas que les éléments d'un $p$-uplet soient tous distincts.

<bubble variant="tip">

#### Attention à l'ordre des éléments

Il faut bien faire attention à l'ordre des éléments ! Prenons par exemple deux points du plan $A = (1; 2)$ et $B = (2;
1)$.

On peut voir $A$ et $B$ comme des $2$-uplets de $\mathbb{R}$. Or, ce sont deux points différents, d'où la nécessité de
bien faire attention à ne pas mélanger $(1; 2)$ et $(2; 1)$.

</bubble>

<bubble variant="tip">

#### Notation

Bien que l'on note un ensemble avec des accolades, on note plutôt un $p$-uplet avec des parenthèses. Ainsi :

* $\{1; 2; 3; 4; 5\}$ désigne l'ensemble constitué des nombres entiers de $1$ à $5$ (on a $\{1; 2; 3; 4; 5\} = \{2; 1;
  3; 4; 5\} = \{5; 4; 3; 2; 1\} = ...$).
* $(1; 2; 3; 4; 5)$ désigne le $5$-uplet constitué des nombres entiers de $1$ à $5$ (on a $(1; 2; 3; 4; 5) \neq (2; 1;
  3; 4; 5) \neq (5; 4; 3; 2; 1) \neq ...$).

</bubble>

## Combinaisons

### Factorielle

<bubble variant="formula">

#### Définition

Soit $n$ un nombre entier. On appelle factorielle de $n$ le nombre entier $n! = 1 \times 2 \times \dots \times n$.

</bubble>

<bubble variant="tip">

#### Convention

Par convention, on pose $0! = 1$.

</bubble>

Il est très courant de rencontrer des calculs avec des factorielles en mathématiques, leur utilisation ne se limitant
pas au dénombrement.

### Qu'est-ce-qu'une combinaison ?

<bubble variant="formula">

#### Définition

Une **combinaison** de $k$ éléments parmi $n$ éléments, notée $\displaystyle{\binom{n}{k}}$, est le nombre de
sous-ensembles de $k$ éléments que possède un ensemble de $n$ éléments.

</bubble>

<bubble variant="formula">

#### Calcul d'une combinaison

Soient $n$ et $k$ deux entiers. Alors $\displaystyle{\binom{n}{k} = \frac{n!}{(n-k)!k!}}$.

</bubble>

<bubble variant="tip">

#### Exemple

Soit $E = \{1, 2, 3, \dots, 30 \}$. On cherche à connaître le nombre de sous-ensembles de $3$ éléments que possède $E$.
Pour cela, il suffit d'appliquer la formule :

$\displaystyle{\binom{30}{3} = \frac{30!}{27!3!} = \frac{28 \times 29 \times 30}{1 \times 2 \times 3} = 4060}$

$E$ contient $4060$ sous-ensembles de $3$ éléments.

</bubble>

### Formules

<bubble variant="formula">

#### Formules

Soient $n$ et $k$ deux entiers.

* $\displaystyle{\binom{n}{0} = \binom{n}{n} = 1}$
* $\displaystyle{\binom{n}{1} = \binom{n}{n-1} = n}$
* $\displaystyle{\binom{n}{k} = \binom{n}{n-k}}$

</bubble>

<bubble variant="tip">

#### Triangle de Pascal

Une autre formule très utile est $\displaystyle{\binom{n}{k} + \binom{n}{k+1} = \binom{n+1}{k+1}}$. Elle peut se
retrouver à l'aide du triangle de Pascal, que l'on construit comme tel :

1. Dans une pyramide, on place un $1$ au sommet de la pyramide.
2. On place $1$ et $1$ en dessous, de part et d'autre.
3. Les extrémités des lignes sont toujours des $1$, et les autres nombres sont la somme des deux nombres directement
   au-dessus.

Les premières lignes du triangle de Pascal sont donc :

![Triangle de Pascal](/img/lessons/terminale/denombrement/pascal.png)

On a alors que le $k$-ième coefficient de la $n$-ième ligne est égal à $\displaystyle{\binom{n}{k}}$ (en partant de $0$)
.

</bubble>

## Dénombrement

### Principe additif

<bubble variant="formula">

#### Principe additif

Soient $E$ et $F$ deux ensembles disjoints contenant respectivement $n$ et $m$ éléments. Alors $E \, \cup \, F$ contient
$n + m$ éléments.

</bubble>

<bubble variant="tip">

#### Exemple

Si on pose $E = \{1; 3; 5\}$ et $F = \{2; 4; 6; 8\}$. On a bien que $E$ et $F$ sont disjoints donc $E \, \cup \, F$
contient $3 + 4 = 7$ éléments.

</bubble>

### Principe multiplicatif

Commençons cette sous-section par une définition.

<bubble variant="formula">

#### Produit cartésien

Soient $E$ et $F$ deux ensembles. Leur produit cartésien $E \times F$ est l'ensemble des couples $(e; f)$ où $e \in E$
et $f \in F$.

</bubble>

<bubble variant="tip">

#### Exemple

Cette définition peut sembler un peu compliquée, mais elle est en faite très intuitive. Prenons $E = \{1; 2; 3\}$ et $F
= \{4; 5\}$.

Alors on a $E \times F = \{(1; 4); (1; 5); (2; 4); (2; 5); (3; 4); (3; 5)\}$.

</bubble>

<bubble variant="tip">

#### Construction du plan cartésien

Prenons maintenant $E = F = \mathbb{R}$.

Le produit cartésien $E \times F$ est l'ensemble des couples $(x; y)$ où $x \in \mathbb{R}$ et $y \in \mathbb{R}$.

Il s'agit en fait du plan cartésien.

</bubble>

<bubble variant="formula">

#### Principe multiplicatif

Soient $E$ et $F$ deux ensembles contenant respectivement $n$ et $m$ éléments. Alors $E \times F$ contient $n \times m$
éléments.

</bubble>

Ce principe (tout comme le principe additif vu précédemment) sont notamment utilisés en probabilités.

### Formules de dénombrement

<bubble variant="formula">

#### Permutations

Soit $E$ un ensemble de taille $n$. On appelle **permutation** de $E$ tout $n$-uplet d'éléments distincts de $E$.

</bubble>

<bubble variant="tip">

#### Exemple

Prenons $E = \{1; 2; 3\}$. Alors $E$ admet $6$ permutations qui sont :

* $(1; 2; 3)$
* $(1; 3; 2)$
* $(2; 1; 3)$
* $(2; 3; 1)$
* $(3; 1; 2)$
* $(3; 2; 1)$

</bubble>

<bubble variant="formula">

#### Formules

Soit $E$ un ensemble possédant $n$ éléments.

* Le nombre de $p$-uplets d'éléments de $E$ est égal à $n^p$.
* Le nombre de $p$-uplets d'éléments distincts de $E$ est égal à $\frac{n!}{(n-p)!}$.
* Le nombre de permutations de $E$ est égal à $n!$.
* Le nombre de sous-ensembles de $E$ est égal à $2^n$.
* Le nombre de sous-ensembles de $k$ éléments que possède $E$ est égal à $\displaystyle{\binom{n}{k}}$ (pour rappel).

</bubble>

À noter également une dernière petite formule qu'il peut être utile de savoir démontrer à l'aide des formules ci-dessus.

<bubble variant="formula">

$\displaystyle{\sum_{k = 0}^n \binom{n}{k} = 2^n}$ pour tout $n \in \mathbb{N}$.

</bubble>

<bubble variant="proof">

Soit $n \in \mathbb{N}$ et soit $E$ un ensemble à $n$ éléments.

Par la dernière formule de dénombrement, $E$ a $\displaystyle{\binom{n}{0}}$ sous-ensembles qui possèdent $0$ éléments,
$\displaystyle{\binom{n}{1}}$ sous-ensembles qui possèdent $1$ éléments, ...

En fait, pour tout $k$ compris entre $0$ et $n$, $E$ a exactement $\displaystyle{\binom{n}{k}}$ sous-ensembles qui
possèdent $k$ éléments (toujours d'après la dernière formule).

Donc finalement, on obtient bien que la somme des $\displaystyle{\binom{n}{k}}$ vaut $2^n$ (qui est, d'après l'
avant-dernière formule, le nombre de sous-ensembles que possède $E$).

</bubble>
