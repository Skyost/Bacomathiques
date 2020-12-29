## Divisibilité et congruence

### Divisibilité

Dans toute la suite de cette section, on notera par $\mathbb{Z}$ l'ensemble des nombres entiers relatifs (i.e.
$\mathbb{Z} = \{\dots, -2, -1, 0, 1, 2, \dots\}$) et par $\mathbb{N}$ l'ensemble des nombres entiers naturels (i.e.
$\mathbb{N} = \{0, 1, 2, \dots\}$).

<bubble variant="formula">

#### Définition

Soient $a$ et $b$ deux entiers relatifs. On dit que $b$ **divise** $a$ (ou que $a$ est **un multiple** de $b$) s'il
existe $k \in \mathbb{Z}$ tel que $a = kb$. On note ceci par $b \, | \, a$.

</bubble>

<bubble variant="formula">

#### Propriétés

* Tout entier relatif $b$ divise $0$ (car $0 = 0 \times b$).
* $1$ divise tout entier relatif $a$ (car $a = a \times 1$).
* Si $c \, | \, a$ et $c \, | \, b$ alors $c \, | \, (au + bv)$ pour tout $u$, $v \in \mathbb{Z}$.

</bubble>

### Division euclidienne

La **division euclidienne** est une notion mathématique que l'on aborde très tôt au cours de notre scolarité (dès la
classe de CM1). Nous allons tenter de formaliser ceci :

<bubble variant="formula">

#### Théorème de la division euclidienne

Soient $a$, $b \in \mathbb{Z}$. On suppose $b \neq 0$. On appelle **division euclidienne** de $a$ par $b$, l'opération
qui à $(a, b)$, associe le couple d'entiers relatifs $(q, r)$ tel que $a = bq + r$ où $0 \leq r \lt |b|$. Un tel
couple **existe** forcément et est **unique**.

</bubble>

<bubble variant="formula">

#### Vocabulaire

En reprenant les notations du théorème, $a$ s'appelle le **dividende**, $b$ le **diviseur**, $q$ le **quotient** et $r$
le **reste** de la division euclidienne.

</bubble>

Donnons enfin une propriété qui nous sera utile dans la section suivante.

<bubble variant="formula">

#### Propriété

Soit $n \in \mathbb{N}$ tel que $n \neq 0$. Deux entiers relatifs $a$ et $b$ ont le même reste dans la division
euclidienne par $n$ si et seulement si $a-b$ est un multiple de $n$.

</bubble>

### Congruences dans $\mathbb{Z}$

<bubble variant="formula">

#### Définition

On dit que deux entiers relatifs $a$ et $b$ sont **congrus modulo $n$** (où $n$ est un entier naturel supérieur ou égal
à $2$) si $a$ et $b$ ont le même reste dans la division euclidienne par $n$. On note alors $a \equiv b \mod n$.

</bubble>

On signale que la congruence est une **relation d'équivalence**.

<bubble variant="formula">

#### Propriétés

Soit $n \geq 2$. Pour tout $a$, $b$, $c \in \mathbb{Z}$ :

* $a \equiv a \mod n$ (**réflexivité**)
* Si $a \equiv b \mod n$, alors $b \equiv a \mod n$ (**symétrie**)
* Si $a \equiv b \mod n$, et si $b \equiv c \mod n$, alors $a \equiv c \mod n$ (**transitivité**)

</bubble>

De plus, la congruence est compatible avec les opérations usuelles sur les entiers relatifs.

<bubble variant="formula">

#### Propriétés

Soit $n \geq 2$. Soient $a$, $b$, $c$ et $d \in \mathbb{Z}$ tels que $a \equiv b \mod n$ et $c \equiv d \mod n$. Alors
on a la compatibilité avec :

* L'**addition** : $a + c \equiv b + d \mod n$.
* La **multiplication** : $ac \equiv bd \mod n$.
* Les **puissances** : pour tout $k \in \mathbb{N}$, $a^k \equiv b^k \mod n$.

</bubble>

## PGCD et théorème de Bézout

### Plus Grand Commun Diviseur

<bubble variant="formula">

#### Définition

Soient $a$, $b \in \mathbb{Z}$ non tous nuls. Le **Plus Grand Commun Diviseur** de $a$ et $b$ (noté
$\operatorname{PGCD}(a; b)$) est le plus grand entier positif qui les divise simultanément.

</bubble>

Avec cette définition, on peut dégager quelques propriétés.

<bubble variant="formula">

#### Propriétés

Soient $a$, $b \in \mathbb{Z}$ non tous nuls.

* $\operatorname{PGCD}(a; b) = \operatorname{PGCD}(b; a)$
* $\operatorname{PGCD}(a; 1) = 1$
* $\operatorname{PGCD}(a; 0) = a$
* Pour tout $k \in \mathbb{N}$, $\operatorname{PGCD}(ka; kb) = k \operatorname{PGCD}(a; b)$
* Si $b \, | \, a$, alors $\operatorname{PGCD}(a; b) = |b|$

</bubble>

Il existe une manière de déterminer le $\operatorname{PGCD}$ de deux entiers naturels non nuls $a$ et $b$ avec $b \lt a$
appelée **Algorithme d'Euclide**.

<bubble variant="formula">

#### Algorithme d'Euclide

Soient $a$, $b \in \mathbb{Z}$ non tous nuls. Pour obtenir $\operatorname{PGCD}(a; b)$, on procède comme suit :

1. On fait la division euclidienne de $a$ par $b$ et on appelle $r$ le reste.
2. Si $r = 0$, alors $\operatorname{PGCD}(a; b) = b$.
3. Sinon on recommence l'étape 1 en remplaçant $a$ par $b$ et $b$ par $r$.

</bubble>

Terminons cette section par une définition.

<bubble variant="formula">

#### Nombres premiers entre eux

On dit que deux nombres sont **premiers entre eux** si leur $\operatorname{PGCD}$ est égal à 1.

</bubble>

### Théorème de Bézout

Un résultat fondamental de l'arithmétique est le **théorème de Bachet-Bézout** (que l'on rencontre parfois sous le nom
d'**identité de Bézout**).

<bubble variant="formula">

#### Théorème de Bachet-Bézout

Soient $a$ et $b$ deux entiers relatifs non nuls. On note $d$ leur PGCD. Alors il existe deux entiers relatifs $u$ et
$v$ tels que $ua + vb = d$.

</bubble>

<bubble variant="formula">

#### Théorème de Bézout

Une conséquence de ce théorème est que $a$ et $b$ sont premiers entre eux si et seulement s'il existe deux entiers
relatifs $u$ et $v$ tels que $ua + vb = 1$.

</bubble>

<bubble variant="formula">

#### Résolution d'une congruence simple

Supposons que l'on souhaite résoudre une congruence du type $ax \equiv b \mod n$ d'inconnue $x$. On pose $d =
\operatorname{PGCD(a; n)}$. Alors :

1. Si $d$ ne divise pas $b$, on cherche deux entiers $u$ et $v$ tels que $au + nv = 1$ (avec l'algorithme d'Euclide
   étendu par exemple). Les solutions de la congruence sont alors les entiers $x$ vérifiant $x \equiv ub \mod n$.
2. Si $d \, | \, b$, cela revient à résoudre la congruence $\displaystyle{\frac{a}{d}x \equiv \frac{b}{d} \mod
   \frac{n}{d}}$, et on se ramène au cas 1 (avec la nouvelle congruence à résoudre).

</bubble>

### Lemme de Gauss

<bubble variant="formula">

#### Lemme de Gauss

Soient $a$, $b$ et $c$ trois entiers non nuls. Si $c \, | \, ab$ et $c$ est premier avec $a$, alors $c \, | \, b$.

</bubble>

<bubble variant="formula">

#### Corollaire

Soient $a$, $b$ et $c$ trois entiers non nuls. Si $b \, | \, a$, $c \, | \, a$ et que $b$ et $c$ sont premiers entre
eux, alors $bc \, | \, a$.

</bubble>

### Équations diophantiennes

<bubble variant="formula">

#### Définition

Une **équation diophantienne linéaire en deux variables** $x$ et $y$ est une équation de la forme $(E) : ax + by = c$ où
les coefficients $a$, $b$ et $c$ sont des entiers relatifs et où les solutions sont également des entiers relatifs.

</bubble>

<bubble variant="formula">

#### Solutions de $(E)$

En reprenant les notations précédentes, on pose $d = \operatorname{PGCD}(a; b)$. Alors :

* Si $d \, | \, c$, on cherche une solution particulière à $(E)$ que l'on note $(x_0; y_0)$. Alors les solutions de $(E)
  $ sont les couples $(x_k; y_k)$ où $\displaystyle{x_k = x_0 + k\frac{b}{d}}$ et $\displaystyle{y_k = y_0 -
  k\frac{a}{d}}$.
* Sinon, $(E)$ n'a pas de solution.

</bubble>

## Nombres premiers

### Définition

Commençons cette section par définir ce qu'est un **nombre premier**. Il s'agit là d'une notion dont entend parler très
tôt au cours de notre scolarité, sans pour autant vraiment rentrer dans le sujet. Détaillons donc un peu tout ceci.

<bubble variant="formula">

#### Nombre premier

Un nombre entier $p \geq 2$ est dit **premier** si ses seuls diviseurs positifs sont $1$ et lui-même.

</bubble>

### Propriétés

Voici quelques propriétés basiques que possèdent les nombres premiers.

<bubble variant="formula">

#### Propriétés

Soit $n \in \mathbb{N}$ supérieur ou égal à 2, alors on a les propriétés suivantes :

* Si $n$ n'admet aucun diviseur premier inférieur ou égal à $\sqrt{n}$, alors $n$ est premier.
* Si $n$ n'est pas premier alors $n$ admet au moins un diviseur premier inférieur ou égal à $\sqrt{n}$.
* Si $n$ est premier et $n$ ne divise pas un entier $m$, alors $n$ et $m$ sont premiers entre eux.

</bubble>

<bubble variant="formula">

#### Lemme d'Euclide

Soit $p$ un nombre premier et $a$ et $b$ deux entiers. Si $p \, | \, ab$ alors $p \, | \, a$ ou $p \, | \, b$.

</bubble>

On donne enfin un résultat fondamental (mais qui reste très simple) sur l'ensemble des nombres premiers.

<bubble variant="formula">

#### Infinité de nombres premiers

Il existe une infinité de nombres premiers.

</bubble>

<bubble variant="formula">

#### Petit théorème de Fermat

Soit $p$ un nombre premier et $a$ un entier non divisible par $p$. Alors $a^{p-1} \equiv 1 \mod p$.

</bubble>

### Décomposition de nombres

Passons maintenant à un résultat fondamental de l'arithmétique : le principe de **décomposition en produit de facteurs
premiers** (il s'agit même là d'un théorème qui est sobrement intitulé **théorème fondamental de l'arithmétique**).

<bubble variant="formula">

#### Théorème fondamental de l'arithmétique

Soit $n \in \mathbb{N}$ supérieur ou égal à 2, alors $n$ peut s'écrire de la façon suivante :

$n = p_{1}^{\alpha_1} \times p_{2}^{\alpha_2} \times \dots \times p_{n}^{\alpha_n}$

où $p_1$, $p_2$, ... , $p_n$ des nombres premiers tels que $p_1 \lt p_2 \lt \dots \lt p_n$ et $\alpha_1$, $\alpha_2$,
... , $\alpha_n$ des entiers naturels non nuls.

</bubble>
