## Qu'est-ce qu'une suite ?

### Définition

On appelle **suite** une fonction de $\mathbb{N}$ dans $\mathbb{R}$ : cette fonction va prendre des éléments de
l'ensemble de départ $\mathbb{N}$ et va les amener dans l'ensemble d'arrivée $\mathbb{R}$.

<bubble variant="formula">

#### Définition

Il y a plusieurs manières de définir une suite :

* **Par récurrence :** On donne le premier terme de la suite ainsi que le terme au rang $n+1$.
* **Par son terme général :** On donne le $n$-ième terme de la suite en fonction de $n$.

</bubble>

**Attention !** Bien que ces deux modes de génération soient les principaux, il en existe d'autres : algorithme, motifs
géométriques, ...

### Suites arithmétiques

<bubble variant="formula">

#### Définition

Une suite $(u_n)$ est dite **arithmétique** si elle est de la forme $u_{n+1} = u_n + r$ avec $r \in \mathbb{R}$.

</bubble>

<bubble variant="formula">

#### Raison

Le réel $r$ est la **raison** de la suite (si $r \gt 0$, $(u_n)$ est strictement croissante, si $r \lt 0$, $(u_n)$ est
strictement décroissante et si $r = 0$, $(u_n)$ est constante).

</bubble>

Il est possible de trouver le terme général d'une suite arithmétique :

<bubble variant="formula">

#### Terme général

On note $p$ le rang initial de la suite (celui à partir duquel la suite est définie) :

$u_n = u_p + (n-p) \times r$

Et si $(u_n)$ est définie à partir du rang $0$ (on a $p = 0$) :

$u_n = u_0 + (n-0) \times r = u_0 + n \times r$

</bubble>

<bubble variant="formula">

#### Somme des termes

$\displaystyle{1 + 2 + \dots + n = \frac{n(n + 1)}{2}}$ pour tout $n \in \mathbb{N}$.

</bubble>

### Suites géométriques

<bubble variant="formula">

#### Définition

Une suite $(v_n)$ est dite **géométrique** si elle est de la forme $v_{n+1} = v_n \times q$ avec $q \in \mathbb{R}$.

</bubble>

<bubble variant="formula">

#### Raison

Le réel $q$ est la **raison** de la suite (si $q \gt 1$, $(v_n)$ est strictement croissante, si $0 \lt q \lt 1$, $(v_n)$
est strictement décroissante et si $q = 1$ ou $0$, $(v_n)$ est constante).

</bubble>

Il est possible de trouver le terme général d'une suite géométrique :

<bubble variant="formula">

#### Terme général

On note $p$ le rang initial de la suite (celui à partir duquel la suite est définie) :

$v_n = v_p \times q^{n-p}$

Et si $(v_n)$ est définie à partir du rang $0$ (on a $p = 0$) :

$v_n = v_0 \times q^{n-0} = v_0 \times q^n$

</bubble>

<bubble variant="formula">

#### Somme des termes

Soit $n \neq 0$ un entier et $q$ un réel, alors :

* Si $q \neq 1$, alors $\displaystyle{1 + q^1 + q^2 + \dots + q^n = \frac{1 - q^{n + 1}}{1 - q}}$.
* Si $q = 1$, alors $\displaystyle{1 + q^1 + q^2 + \dots + q^n = \underbrace{1 + 1 + 1 + \dots + 1}_{n \text{ fois}} =
  n}$.

</bubble>

## Étude des suites

### Sens de variation

<bubble variant="formula">

#### Définition

Soit $(u_n)$ une suite.

* $(u_n)$ est **croissante** si on a $u_{n+1} \geq u_n$ (ou $u_{n+1} - u_n \geq 0$) pour tout $n \in \mathbb{N}$.
* $(u_n)$ est **décroissante** si on a $u_{n+1} \leq u_n$ (ou $u_{n+1} - u_n \leq 0$) pour tout $n \in \mathbb{N}$.
* $(u_n)$ est dite **constante** s'il existe $c \in \mathbb{R}$ tel que $u_n = c$ pour tout $n \in \mathbb{N}$.

</bubble>

Si une suite est croissante ou décroissante et ne change pas de variation, alors elle est dite **monotone**.

### Introduction aux limites

Quand on souhaite s'intéresser à la limite d'une suite $(u_n)$, on étudie le comportement de ses termes quand <q>$n$
devient très grand</q>. On préfère dire alors que **$n$ tend vers $+\infty$**.

<bubble variant="formula">

#### Définition

Soit $(u_n)$ une suite.

* Si $(u_n)$ tend vers un réel quand $n$ tend vers $+\infty$, on dit qu'elle **converge**.
* Si $(u_n)$ tend vers une limite infinie quand $n$ tend vers $+\infty$, on dit qu'elle **diverge**.

</bubble>

À savoir que si une suite a une limite, alors cette limite est **unique**. Mais il est également possible pour une suite
de ne pas admettre de limite.

### Représentation graphique

Il est possible de représenter graphiquement une suite. Cela peut aider, par exemple dans le but de chercher sa limite.

<bubble variant="formula">

#### Méthode pour une suite définie par récurrence

Soit $(u_n)$ une suite définie par récurrence. Pour représenter $(u_n)$ dans un graphique :

1. On trace la droite d'équation $y = x$.
2. Comme cette suite est définie par récurrence, pour tout entier $n$ on a une relation du type $u_{n+1} = f(u_n)$. Il
   s'agit de tracer la courbe représentative $\mathcal{C}_f$ de la fonction $f$.
3. On place le point $A$ de coordonnées $(u_0; 0)$
4. On trace une droite verticale passant par $A$, son intersection avec $\mathcal{C}_f$ donne un point $B = (u_0; u_1)$.
5. À l'aide du point $B$, on place le point $C = (0; u_1)$.
6. On trace une droite horizontale passant par $C$, son intersection avec la droite $y = x$ donne un point $D = (u_1;
   u_1)$.
7. Une fois le point $D$ obtenu, on place le point $(u_1; 0)$.
8. On recommence l'opération en remplaçant $u_0$ par $u_1$ et $u_1$ par $u_2$, puis on recommence, etc.

</bubble>

Il est cependant plus facile de représenter graphiquement une suite dont on connaît le terme général.

<bubble variant="formula">

#### Méthode pour une suite définie par son terme général

Soit $(v_n)$ une suite définie par son terme général. Pour représenter $(v_n)$ dans un graphique :

1. On place le point de coordonnées $(0; v_0)$.
2. On place le point de coordonnées $(1; v_1)$.
3. On place le point de coordonnées $(2; v_2)$. Etc.

</bubble>
