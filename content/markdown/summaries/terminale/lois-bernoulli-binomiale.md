## Rappels sur les variables aléatoires

### Définition

Nous allons rappeler quelques notions vues en classe de Première sur les variables aléatoires.

<bubble variant="formula">

#### Définition

Une **variable aléatoire** $X$ est une fonction qui, à chaque événement élémentaire de l'univers $\Omega$ y associe un
nombre réel. C'est-à-dire : $X : \Omega \rightarrow \mathbb{R}$.

</bubble>

### Loi de probabilité

<bubble variant="formula">

#### Définition

Soit $X$ une variable aléatoire. La **loi de probabilité** de $X$ attribue à chaque valeur $x_i$ la probabilité $p_i =
p(X = x_i)$ de l'événement $X = x_i$ constitué de tous les événements élémentaires dont l'image par $X$ est $x_i$.

</bubble>

On représente généralement les lois de probabilité par un tableau.

<bubble variant="formula">

#### Représentation d'une loi de probabilité par un tableau

Soit $X$ une variable aléatoire. On peut représenter sa loi de probabilité par le tableau ci-contre :

| $x_i$                 | $x_1$                 | $x_2$                 | ... | $x_n$                 |
| --------------------- | --------------------- | --------------------- | --- | --------------------- |
| $p_i$ $= p(X = x_i)$ | $p_1$ $= p(X = x_1)$ | $p_2$ $= p(X = x_2)$ | ... | $p_n$ $= p(X = x_n)$ |

On a $p_1 + p_2 + \dots + p_n = 1$.

</bubble>

### Espérance, variance et écart-type

<bubble variant="formula">

#### Espérance

L'**espérance** $E(X)$ d'une variable aléatoire $X$ est le réel :

$E(X) = x_1 \times p_1 + x_2 \times p_2 + \dots + x_n \times p_n$.

</bubble>

<bubble variant="formula">

#### Variance et écart-type

La **variance** $V(X)$ et l'**écart-type** $\sigma(X)$ d'une variable aléatoire $X$ sont les réels positifs suivants :

* $V(X) = E(X^2) - E(X)^2$
* $\sigma(X) = \sqrt{V(X)}$

</bubble>

Chacun de ces paramètres a une utilité bien précise. En effet :

<bubble variant="formula">

#### Signification des paramètres

* L'espérance est la **valeur moyenne** prise par $X$.
* La variance et l'écart-type mesurent la **dispersion** des valeurs prises par $X$. Plus ces valeurs sont grandes, plus
  les valeurs sont dispersées autour de l'espérance.

</bubble>

## Loi de Bernoulli

### Succession d'épreuves indépendantes

<bubble variant="formula">

#### Univers associé

Soit une succession de $n$ épreuves indépendantes (c'est-à-dire que le résultat de l'une n'a pas d'incidence sur le
résultat de la suivante). On note les univers associés à chaque expérience respectivement par $\Omega_1$, $\Omega_2$,
... , $\Omega_n$.

Alors l'univers associé à cette succession d'épreuves indépendantes est le produit cartésien $\Omega_1 \times \Omega_2
\times \dots \times \Omega_n$.

</bubble>

<bubble variant="formula">

#### Calcul de probabilité

Soit une succession de $n$ épreuves indépendantes et soit $(x_1, \dots, x_n)$ une issue de cette succession d'épreuves.
Alors $p((x_1, \dots, x_n)) = p(x_1) \times \dots \times p(x_n)$.

</bubble>

### Épreuve et schéma de Bernoulli

Derrière ces noms qui peuvent sembler compliquer, se cache une notion finalement simple, et que l'on rencontre souvent
dans la vie quotidienne.

<bubble variant="formula">

#### Épreuve de Bernoulli

Une **épreuve de Bernoulli** est une expérience aléatoire qui n'admet que deux issues possibles : le succès et l'échec.

</bubble>

Il est souvent possible de répéter plusieurs fois une épreuve de Bernoulli. C'est ce qu'on appelle un **schéma de
Bernoulli**.

<bubble variant="formula">

#### Schéma de Bernoulli

Soit une succession d'épreuves de Bernoulli indépendantes. On appelle cette succession un schéma de Bernoulli.

</bubble>

### Qu'est-ce qu'une loi de Bernoulli ?

<bubble variant="formula">

#### Définition

Soient $X$ une variable aléatoire et $p \in ]0; 1[$. On dit que $X$ suit une \text{loi de Bernoulli} de paramètre
$p$ (qui se note $\mathcal{B}(p)$) si la loi de $X$ est la suivante :

<table class="table table-bordered table-hover"><tbody><tr><td>$x_i$</td><td>$0$</td><td>$1$</td></tr><tr><td>$p_i$</td><td>$1 - p$</td><td>$p$</td></tr></tbody></table>

C'est-à-dire, qu'on a une probabilité $p$ d'obtenir un succès (représenté par $1$) et une probabilité de $1-p$ d'obtenir
un échec (représenté par $0$).

</bubble>

Il est possible de calculer facilement l'espérance, la variable et l'écart-type d'une variable aléatoire suivant ce type
de loi.

<bubble variant="formula">

#### Espérance, variance et écart-type

Soit $X$ une variable aléatoire suivant une loi de Bernoulli $\mathcal{B}(p)$. Alors :

* $E(X) = p$.
* $V(X) = p(1-p)$.
* $\sigma(X) = \sqrt{p(1-p)}$.

</bubble>

## Loi binomiale

### Définition

Une loi de Bernoulli permet de modéliser ce qui se passe dans le cas d'une seule épreuve de Bernoulli. Cependant, il
peut arriver que l'on souhaite voir ce qu'il se passe dans le cadre d'un schéma de Bernoulli (c'est-à-dire, en répétant
indépendamment plusieurs fois une épreuve de Bernoulli).

<bubble variant="formula">

#### Définition

Soient $n \in \mathbb{N}^*$ et $p \in ]0; 1[$. On se place dans le cadre d'un schéma de Bernoulli à $n$ répétitions
et où la probabilité de succès des épreuves est $p$.

La loi de probabilité donnant le nombre de succès sur ces $n$ répétitions est la **loi binomiale** de paramètres $n$ et
$p$ (notée $\mathcal{B}(n; p)$).

</bubble>

### Calculs de probabilités

<bubble variant="formula">

#### Probabilité d'un nombre de succès

Soit $X$ une variable aléatoire suivant une loi $\mathcal{B}(n; p)$. Alors pour tout entier $k$ compris entre $0$ et
$n$, on a $\displaystyle{p(X = k) = \binom{n}{k} p^k (1-p)^{n-k}}$.

</bubble>

Comme on l'a dit précédemment, il est tout à fait possible d'utiliser des arbres de probabilités pour répondre à ce
genre de questions.

### Espérance, variance et écart-type

<bubble variant="formula">

#### Espérance, variance et écart-type

Soit $X$ une variable aléatoire suivant $\mathcal{B}(n; p)$. Alors :

* $E(X) = np$.
* $V(X) = np(1-p)$.
* $\sigma(X) = \sqrt{np(1-p)}$.

</bubble>
