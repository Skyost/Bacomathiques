## Définitions

### Ensemble d'éléments

Cette partie donne quelques rappels sur la notion d'ensemble en mathématiques.

<bubble variant="formula">

#### Définition

Un **ensemble** $E$ désigne une collection finie ou infinie d'objets distincts qu'on appelle ses **éléments**.

On note $x \in E$ si l'objet $x$ appartient à $E$. Dans le cas contraire, on note $x \notin E$.

</bubble>

À noter que l'ordre des objets n'a aucune importance lorsque l'on compare deux ensembles.

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

### Liste d'éléments

Nous allons désormais voir un type de collection similaire aux ensembles, mais qui prend en compte l'ordre des éléments.

<bubble variant="formula">

#### Définition

Un **$p$-uplet** (ou une $p$-liste) d'un ensemble $E$ désigne une collection ordonnée de $p$ éléments de $E$.

</bubble>

Remarquons que l'on ne demande pas que les éléments d'un $p$-uplet soient tous distincts.

## Combinaisons

### Factorielle

<bubble variant="formula">

#### Définition

Soit $n$ un nombre entier. On appelle factorielle de $n$ le nombre entier $n! = 1 \times 2 \times \dots \times n$.

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

### Formules

<bubble variant="formula">

#### Formules

Soient $n$ et $k$ deux entiers.

* $\displaystyle{\binom{n}{0} = \binom{n}{n} = 1}$
* $\displaystyle{\binom{n}{1} = \binom{n}{n-1} = n}$
* $\displaystyle{\binom{n}{k} = \binom{n}{n-k}}$

</bubble>

## Dénombrement

### Principe additif

<bubble variant="formula">

#### Principe additif

Soient $E$ et $F$ deux ensembles disjoints contenant respectivement $n$ et $m$ éléments. Alors $E \, \cup \, F$ contient
$n + m$ éléments.

</bubble>

### Principe multiplicatif

Commençons cette sous-section par une définition.

<bubble variant="formula">

#### Produit cartésien

Soient $E$ et $F$ deux ensembles. Leur produit cartésien $E \times F$ est l'ensemble des couples $(e; f)$ où $e \in E$
et $f \in F$.

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

<bubble variant="formula">

#### Formules

Soit $E$ un ensemble possédant $n$ éléments.

* Le nombre de $p$-uplets d'éléments de $E$ est égal à $n^p$.
* Le nombre de $p$-uplets d'éléments distincts de $E$ est égal à $\frac{n!}{(n-p)!}$.
* Le nombre de permutations de $E$ est égal à $n!$.
* Le nombre de sous-ensembles de $E$ est égal à $2^n$.
* Le nombre de sous-ensembles de $k$ éléments que possède $E$ est égal à $\displaystyle{\binom{n}{k}}$ (pour rappel).

</bubble>
