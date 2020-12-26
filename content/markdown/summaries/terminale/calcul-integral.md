## Calcul d'aire

### Qu'est-ce qu'une intégrale ?

Dans un repère orthogonal $(O; \overrightarrow{i}; \overrightarrow{j})$, on prend un point $A = (1; 1)$ et on appelle **
Unité d'Aire** (U.A.) l'aire du rectangle formé par les points $O$, $I$, $A$ et $J$.

<representation geogebra-id="mxqfqsm5"></representation>

Soient $a$ et $b$ deux réels avec $a \leq b$ et $f$ une fonction continue sur $[a;b]$. L'**intégrale** de la fonction
$f$ sur $[a;b]$ notée $\displaystyle{\int_{a}^{b} f(x) \, \mathrm{d}x}$ représente l'aire entre la courbe de $f$ et
l'axe des abscisses délimitée par les droites d'équation $x = a$ et $x = b$ et est exprimée en **U.A.**.

<representation geogebra-id="txmfnhst"></representation>

On dit que les réels $a$ et $b$ sont les **bornes** de l'intégrale.

### Théorème fondamental de l'analyse

Pour calculer l'intégrale d'une fonction, il faut d'abord trouver la primitive de celle-ci (voir le cours sur
les [primitives](/cours/terminale/primitives/)).

<bubble variant="formula">

#### Théorème fondamental de l'analyse

Soient une fonction $f$ continue sur un intervalle $I$ et deux réels $a$ et $b$ appartenant à $I$.

Alors $\displaystyle{\int_{a}^{b} f(x) \, \mathrm{d}x = \left[ F(x) \right]_a^b = F(b) - F(a)}$ où $F$ est une primitive
de $f$ sur $I$.

</bubble>

### Signe de l'intégrale

De manière générale, le signe de l'intégrale d'une fonction sur un intervalle dépend du signe de cette fonction sur cet
intervalle.

<bubble variant="formula">

#### Relation signe de l'intégrale - signe de la fonction

Soient une fonction $f$ continue sur un intervalle $I = [a; b]$.

* Si $f \gt 0$ sur $I$, alors $\displaystyle{\int_{a}^{b} f(x) \, \mathrm{d}x \gt 0}$.
* Si $f \lt 0$ sur $I$, alors $\displaystyle{\int_{a}^{b} f(x) \, \mathrm{d}x \lt 0}$.
* Si $f$ change de signe sur $I$, on ne connaît pas directement le signe de l'intégrale. Le signe dépend de la partie de
  l'aire qui est la plus grande.
* Soit $g$ une fonction définie sur $I$ avec $f \gt g$ sur $I$, alors $\displaystyle{\int_{a}^{b} f(x) \, \mathrm{d}x
  \gt \int_{a}^{b} g(x) \, \mathrm{d}x}$.

</bubble>

Ainsi, cette intégrale sera positive :

<representation geogebra-id="egjpfkzq"></representation>

Et cette intégrale sera négative :

<representation geogebra-id="zyjkgrkc"></representation>

## Propriétés de l'intégrale

### Propriétés algébriques

<bubble variant="formula">

#### Propriétés

Soient une fonction $f$ continue sur un intervalle $I$ et deux réels $a$ et $b$ appartenant à $I$.

* $\displaystyle{\int_{a}^{b} f(x) \, \mathrm{d}x = - \int_{b}^{a} f(x) \, \mathrm{d}x}$
* $\displaystyle{\int_{a}^{a} f(x) \, \mathrm{d}x = 0}$

</bubble>

### Linéarité

<bubble variant="formula">

#### Linéarité de l'intégrale

Soient une fonction $f$ continue sur un intervalle $I$ et deux réels $a$ et $b$ appartenant à $I$. Soit $\lambda$ un
réel quelconque.

* $\displaystyle{\int_{a}^{b} f(x) + g(x) \, \mathrm{d}x = \int_{b}^{a} f(x) \, \mathrm{d}x + \int_{b}^{a} g(x) \,
  \mathrm{d}x}$
* $\displaystyle{\int_{a}^{b} \lambda f(x) \, \mathrm{d}x = \lambda \int_{b}^{a} f(x) \, \mathrm{d}x}$

</bubble>

### Relation de Chasles

<bubble variant="formula">

#### Relation de Chasles

Soient une fonction $f$ continue sur un intervalle $I$ et deux réels $a$ et $b$ appartenant à $I$.

Pour tout $c \in I$, on a $\displaystyle{\int_{a}^{b} f(x) \, \mathrm{d}x = \int_{a}^{c} f(x) \, \mathrm{d}x + \int_
{c}^{b} f(x) \, \mathrm{d}x}$.

</bubble>

## Calculs d'intégrale

### Intégration par parties

Il peut arriver que vous ayez à intégrer un produit de fonctions. En classe de Terminale, il est possible de faire appel
à une technique appelée **intégration par parties** pour en venir à bout.

<bubble variant="formula">

#### Intégration par parties

Soient $u$ et $v$ deux fonctions dérivables sur un intervalle $I$ et soient $a$ et $b$ appartenant à $I$.

Alors $\displaystyle{\int_a^b u'(x) v(x) \, \mathrm{d}x = \left[u(x) v(x)\right]_a^b - \int_a^b u(x) v'(x) \,
\mathrm{d}x}$.

</bubble>

### Intégrales de fonctions paires et impaires

<bubble variant="formula">

#### Intégrale d'une fonction paire

Soit $f$ une **fonction paire** continue sur un intervalle $I$ (comme $x \mapsto x^2$).

On a la relation suivante pour tout $a \in I$ ($-a$ doit aussi être dans $I$) :

$\displaystyle{\int_{-a}^{a} f(x) \, \mathrm{d}x = 2 \times \int_{0}^{a} f(x) \, \mathrm{d}x = 2 \times \int_{-a}^{0} f(
x) \, \mathrm{d}x}$.

</bubble>

<bubble variant="formula">

#### Intégrale d'une fonction impaire

Soit $f$ une **fonction impaire** continue sur un intervalle $I$ (comme $x \mapsto x^3$).

On a la relation suivante pour tout $a \in I$ ($-a$ doit aussi être dans $I$) :

$\displaystyle{\int_{-a}^{a} f(x) \, \mathrm{d}x = 0}$.

</bubble>

### Intégrales de fonctions périodiques

<bubble variant="formula">

#### Intégrale d'une fonction périodique

Soit $f$ une **fonction périodique** de période $T$ (comme $\cos$ avec $T = 2\pi$) continue sur chacune de ses périodes,
on a la relation suivante pour tout $a \in \mathbb{R}$ :

$\displaystyle{\int_{0}^{T} f(x) \, \mathrm{d}x = \int_{a}^{a + T} f(x) \, \mathrm{d}x}$

</bubble>

### Valeur moyenne d'une fonction

<bubble variant="formula">

#### Valeur moyenne

Soient $f$ une fonction continue sur un intervalle $[a;b]$. La valeur moyenne $M$ de $f$ sur $[a;b]$ est donnée par
$\displaystyle{M = \frac{1}{b-a}\int_{a}^{b} f(x) \, \mathrm{d}x}$.

</bubble>

### Aire entre deux courbes

<bubble variant="formula">

#### Différence d'aires

Soient $f$ et $g$ deux fonctions continues sur un intervalle $[a;b]$. Si on a $f \geq g$ sur cet intervalle, alors
l'aire entre les deux courbes est donnée par $\displaystyle{\int_{a}^{b} f(x) - g(x) \, \mathrm{d}x}$.

</bubble>

### Primitive s'annulant en $a$

<bubble variant="formula">

#### Existence d'une primitive s'annulant en un point

Soient une fonction $f$ continue sur un intervalle $I$ et un réel $a \in I$. La primitive de $f$ sur $I$ qui vaut $0$ en
$a$ (notée $F_a$) est donnée par $\displaystyle{F_a : x \mapsto \int_{a}^{x} f(t) \, \mathrm{d}t}$.

</bubble>
