## Somme de deux variables aléatoires

### Définition

Il arrive que, on ne puisse pas modéliser une situation donnée à l'aide d'une seule variable aléatoire simple. C'est
pourquoi il est parfois utile d'en additionner plusieurs ou bien d'en multiplier par un réel.

<bubble variant="formula">

#### Définition

Soient $X$ et $Y$ deux variables aléatoires définies sur un univers $\Omega$ et soit $\lambda$ un réel. On définit :

* $X + Y$ la variable aléatoire somme de $X$ et $Y$ définie pour tout $\omega \in \Omega$ par $(X + Y)(\omega) = X(
  \omega) + Y(\omega)$.
* $\lambda X$ la variable aléatoire produit de $\lambda$ et $X$ définie pour tout $\omega \in \Omega$ par $(\lambda X)(
  \omega) = \lambda X(\omega)$.

</bubble>

### Espérance, variance et écart-type

Une somme de variable aléatoire reste une variable aléatoire. Donc il est tout à fait possible de calculer l'espérance,
la variance, l'écart-type, ... d'une somme de variables aléatoires.

Voyons dans un premier temps une propriété de l'espérance permettant de calculer plus facilement l'espérance d'une
combinaison linéaire de variables aléatoires.

<bubble variant="formula">

#### Linéarité de l'espérance

Soient $X$ et $Y$ deux variables aléatoires définies sur un univers $\Omega$ et soit $\lambda$ un réel. Alors :

* $E(X + Y) = E(X) + E(Y)$.
* $E(\lambda X) = \lambda E(X)$.

</bubble>

Voyons désormais des formules permettant de calculer la variance et l'écart-type d'une combinaison linéaire de variables
aléatoires.

<bubble variant="formula">

#### Variance et écart-type

Soient $X$ et $Y$ deux variables aléatoires définies sur un univers $\Omega$ et soit $\lambda$ un réel. Alors :

* $V(X + Y) = V(X) + V(Y)$ si $X$ et $Y$ sont indépendantes (c'est-à-dire si le résultat de l'une n'a pas d'incidence
  sur le résultat de l'autre).
* $V(\lambda X) = \lambda^2 V(X)$.
* $\sigma(\lambda X) = \sqrt{\lambda^2} \sigma(X)$.

</bubble>

## Somme de plusieurs variables aléatoires

### Définition et propriétés

Nous allons tenter de généraliser un petit peu le concept vu dans la section précédente. En effet, au lieu d'étudier la
somme de deux variables aléatoires, on va étudier la somme de $n$ variables aléatoires.

En classe de Terminale, on se limite au cas où ces variables aléatoires suivent une même loi.

<bubble variant="formula">

#### Échantillon aléatoire

Un $n$-uplet de variables aléatoires $(X_1, X_2, \dots, X_n)$ qui sont toutes indépendantes et qui suivent une même loi
de probabilité est appelé **échantillon aléatoire de taille $n$ associé à cette loi**.

</bubble>

<bubble variant="formula">

#### Espérance de variables aléatoires de même loi

Soit $(X_1, X_2, \dots, X_n)$ un échantillon aléatoire de taille $n$. On pose $S_n = X_1 + X_2 + \dots + X_n$ et $M_n =
\frac{S_n}{n}$. Alors :

* $E(S_n) = nE(X_1)$ et $V(S_n) = nV(X_1)$.
* $E(M_n) = E\left(\frac{S_n}{n}\right) = \frac{E(S_n)}{n} = E(X_1)$ et $V(M_n) = \frac{V(S_n)}{n^2} = \frac{V(X_1)
  }{n}$.

</bubble>

### Somme / décompositions de certaines variables aléatoires

Nous allons maintenant énoncer une propriété utile qui permet de trouver la loi suivie par une somme de variables
aléatoires indépendantes suivant une loi de Bernoulli.

<bubble variant="formula">

#### Somme de variables aléatoires indépendantes suivant une même loi de Bernoulli

Soit $(X_1, X_2, \dots, X_n)$ un échantillon aléatoire de taille $n$ associé à une loi de Bernoulli de paramètre $p$.

Alors $X_1 + X_2 + \dots + X_n$ suit une loi binomiale $\mathcal{B}(n; p)$.

</bubble>

Enfin, signalons qu'il existe une réciproque de la première propriété qui permet de transformer une variable aléatoire
suivant une loi binomiale en somme de variables aléatoires suivant une loi de Bernoulli.

<bubble variant="formula">

#### Décomposition d'une variable aléatoire suivant une loi binomiale

Soit $X$ une variable aléatoire suivant une loi binomiale $\mathcal{B}(n; p)$.

Alors il existe $n$ variables aléatoires indépendantes $X_1$, $X_2$, ... , $X_n$ suivant toutes une loi de Bernoulli
$\mathcal{B}(p)$, et telles que $X = X_1 + X_2 + \dots + X_n$.

</bubble>

## Concentration et loi des grands nombres

### Inégalité de Bienaymé-Tchebychev

<bubble variant="formula">

#### Inégalité de Bienaymé-Tchebychev

Soit $X$ une variable aléatoire d'espérance $E(X) = \mu$ et de variance $V(X) = V$. Alors pour tout réel strictement
positif $\delta$, $P(|X-\mu| \geq \delta) \leq \frac{V}{\delta^2}$.

</bubble>

### Inégalité de concentration

<bubble variant="formula">

#### Inégalité de concentration

Soit $(X_1, X_2, \dots, X_n)$ un échantillon aléatoire de taille $n$ associé à une loi d'espérance $\mu$ et de variance
$V$. On pose $M_n = \frac{X_1 + X_2 + \dots + X_n}{n}$, la moyenne empirique de cet échantillon.

Alors pour tout réel strictement positif $\delta$, $P(|M_n - \mu| \geq \delta) \leq \frac{V}{n \delta^2}$.

</bubble>

### Loi des grands nombres

<bubble variant="formula">

#### Loi faible des grands nombres

Soit $(X_1, X_2, \dots, X_n)$ un échantillon aléatoire de taille $n$ associé à une loi d'espérance $\mu$ et de variance
$V$. On pose $M_n = \frac{X_1 + X_2 + \dots + X_n}{n}$, la moyenne empirique de cet échantillon.

Alors pour tout réel strictement positif $\delta$, $\lim_{n \rightarrow +\infty} P(|M_n - \mu| \geq \delta) = 0$.

</bubble>
