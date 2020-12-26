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

<bubble variant="tip">

#### Exemple

On définit les suites $(u_n)$ et $(v_n)$ ainsi :

* $u_n = n$ pour tout $n \in \mathbb{N}$ ($(u_n)$ est définie par son terme général).
* $(v_n) = \begin{cases} v_0 = 0 \\ v_{n+1} = v_n + 1 \text{ pour tout } n \geq 1 \end{cases}$ ($(v_n)$ est définie par
  récurrence).

On remarque que bien que définies différemment, $(u_n)$ et $(v_n)$ sont égales.

</bubble>

<bubble variant="tip">

À ne pas confondre :

* $(u_n)$ qui est la **suite** $(u_n)$.
* $u_n$ qui est le **$n$-ième terme** de la suite $(u_n)$.

Ce ne sont pas les mêmes objets : le premier est une suite, le second est un réel.

</bubble>

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

<bubble variant="proof">

#### Terme général

On a $u_{p+1} = u_p + r$. Puis, $u_{p+2} = u_{p+1} + r = u_p + r + r = u_p + 2 \times r$. De même, $u_{p+3} = u_{p+2} +
r = u_p + 3 \times r$ et caetera.

En fait, pour tout $k$ entier plus grand que $p$, on a $u_{p+k} = u_p + k \times r$.

Donc si on pose $n = p+k$, alors $u_n = u_p + (n-p) \times r$.

</bubble>

<bubble variant="formula">

#### Somme des termes

$\displaystyle{1 + 2 + \dots + n = \frac{n(n + 1)}{2}}$ pour tout $n \in \mathbb{N}$.

</bubble>

<bubble variant="proof">

#### Somme des termes

On pose pour tout $n \in \mathbb{N}$, $S_n = 1 + 2 + \dots + n$. On a également $S_n = n + (n-1) + \dots + 1$ (en
écrivant la somme à l'envers).

D'où $S_n + S_n = 2S_n = \underbrace{(n + 1) + (n + 1) + \dots + (n + 1)}_{n \text{ fois}} = n \times (n + 1)$. Et ainsi
$\displaystyle{S_n = \frac{n(n + 1)}{2}}$.

</bubble>

<bubble variant="tip">

#### Exemple

On souhaite calculer $S = 24 + 25 + \dots + 104$.

En fait, $S = 1 + 2 + \dots + 23 + 24 + 25 + \dots + 104 - (1 + 2 + \dots + 23)$. Calculons les deux sommes séparément :

* $1 + 2 + \dots + 23 = \displaystyle{\frac{23 \times 24}{2}} = 276$
* $1 + 2 + \dots + 104 = \displaystyle{\frac{104 \times 105}{2}} = 5460$

D'où $S = 5460 - 276 = 5184$.

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

<bubble variant="proof">

#### Terme général

On a $v_{p+1} = v_p \times q$. Puis, $v_{p+2} = v_{p+1} \times q = v_p \times q \times q = v_p \times q^2$. De même, $v_
{p+3} = v_{p+2} \times q = v_p \times q^3$ et caetera.

En fait, pour tout $k$ entier plus grand que $p$, on a $v_{p+k} = v_p \times q^k$.

Donc si on pose $n = p+k$, alors $v_n = v_p \times q^{n-p}$.

</bubble>

<bubble variant="formula">

#### Somme des termes

Soit $n \neq 0$ un entier et $q$ un réel, alors :

* Si $q \neq 1$, alors $\displaystyle{1 + q^1 + q^2 + \dots + q^n = \frac{1 - q^{n + 1}}{1 - q}}$.
* Si $q = 1$, alors $\displaystyle{1 + q^1 + q^2 + \dots + q^n = \underbrace{1 + 1 + 1 + \dots + 1}_{n \text{ fois}} =
  n}$.

</bubble>

<bubble variant="proof">

#### Somme des termes

Le cas $q = 1$ étant donné juste au-dessus, on supposera $q \neq 1$. On pose pour tout $n \in \mathbb{N}$, $S_n = 1 +
q^1 + q^2 + \dots + q^n$.

On a : $qS_n = q^1 + q^2 + q^3 + \dots + q^{n+1}$, puis : $S_n - qS_n = 1 + q^1 + q^2 + \dots + q^n - q^1 - q^2 - q^3 -
\dots - q^{n+1} = 1 - q^{n+1}$.

Donc on a en factorisant par $S_n$ : $(1 - q)S_n = 1 - q^{n+1} \iff S_n = \frac{1 - q^{n+1}}{1 - q}$.

</bubble>

<bubble variant="tip">

#### Exemple

On souhaite calculer $S = 3^5 + 3^6 + \dots + 3^{10}$.

En fait, $S = 1 + 3 + \dots + 3^4 + 3^5 + 3^6 + \dots + 3^{10} - (1 + \dots + 3^4)$. Calculons les deux sommes
séparément :

* $1 + 3 + \dots + 3^4 = \displaystyle{\frac{1 - 3^5}{1 - 3}} = 121$
* $1 + 3 + \dots + 3^{10} = \displaystyle{\frac{1 - 3^{11}}{1 - 3}} = 88573$

D'où $S = 88573 - 121 = 88452$.

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

<bubble variant="tip">

#### Exemple

On définit la suite $(u_n)$ pour tout $n \in \mathbb{N}$ par $u_n = \frac{1}{n}$. On souhaite trouver la limite possible
de cette suite en $+ \infty$.

Pour cela, regardons les valeurs que prend cette suite pour des valeurs de $n$ très grandes :

| $n$             | $u_n$           |
| --------------- | --------------- |
| $100$           | $0,01$          |
| $1 000$         | $0,001$         |
| $100 000$       | $0,000 01$      |
| $1 000 000 000$ | $0,000 000 001$ |

**Il semble que** cette suite converge vers 0.

</bubble>

À savoir que si une suite a une limite, alors cette limite est **unique**. Mais il est également possible pour une suite
de ne pas admettre de limite.

<bubble variant="tip">

#### Exemple

On définit la suite $(u_n)$ pour tout $n \in \mathbb{N}$ par $u_n = (-1)^n$. On souhaite trouver la limite possible de
cette suite en $+ \infty$.

| $n$         | $u_n$ |
| ----------- | ----- |
| $100$       | $1$   |
| $101$       | $-1$  |
| $1 000 000$ | $1$   |
| $1 000 001$ | $-1$  |

En fait, si $n$ est pair cette suite vaut $1$ et si $n$ est impair elle vaut $-1$. Cette suite n'admet donc pas de
limite : elle diverge.

</bubble>

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

<bubble variant="tip">

#### Exemple

Représentation des trois premiers termes de la suite $(u_n) = \begin{cases} u_0 = 3 \\ u_{n+1} = \frac{u_n}{2}
\end{cases}$.

<representation geogebra-id="zkvhccnn"></representation>

</bubble>

Il est cependant plus facile de représenter graphiquement une suite dont on connaît le terme général.

<bubble variant="formula">

#### Méthode pour une suite définie par son terme général

Soit $(v_n)$ une suite définie par son terme général. Pour représenter $(v_n)$ dans un graphique :

1. On place le point de coordonnées $(0; v_0)$.
2. On place le point de coordonnées $(1; v_1)$.
3. On place le point de coordonnées $(2; v_2)$. Etc.

</bubble>

<bubble variant="tip">

#### Exemple

Représentation des trois premiers termes de la suite $(v_n)$ définie pour tout $n \in \mathbb{N}$ par $v_n = 2^n$.

<representation geogebra-id="qvc3drk9"></representation>

</bubble>
