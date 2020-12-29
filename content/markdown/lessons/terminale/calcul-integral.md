## Calcul d'aire

### Qu'est-ce qu'une intégrale ?

Dans un repère orthogonal $(O; \overrightarrow{i}; \overrightarrow{j})$, on prend un point $A = (1; 1)$ et on appelle
**Unité d'Aire** (U.A.) l'aire du rectangle formé par les points $O$, $I$, $A$ et $J$.

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

<bubble variant="tip">

#### Exemple

On veut calculer l'aire entre la courbe d'une fonction $f$ définie pour tout $x \in \mathbb{R}$ par $f(x) = 2x + 1$, et
l'axe des abscisses sur l'intervalle $[1;4]$ :

**1<sup>ère</sup> étape :** On cherche une primitive de $f$. On trouve $F(x) = x^2 + x = x(x + 1)$.

**2<sup>ème</sup> étape :** On calcule l'intégrale.

On a $\displaystyle{\int_{1}^{4} 2x + 1 \, \mathrm{d}x} = \left[ x(x + 1) \right]_1^4 = 4(4 + 1) - 1(1 + 1) = 20 - 2 =
18$ U.A.

</bubble>

<bubble variant="tip">

#### Autre exemple

On veut calculer l'aire entre la courbe d'une fonction $f$ définie pour tout $x \in \mathbb{R}$ par $f(x) = x$, et l'axe
des abscisses sur l'intervalle $[-2;2]$ :

**1<sup>ère</sup> étape :** On cherche une primitive de $f$. On trouve pour tout $x \in \mathbb{R}$, $F(x) =
\frac{x^2}{2}$.

**2<sup>ème</sup> étape :** On calcule l'intégrale. On a $\displaystyle{\int_{-2}^{2} x \, \mathrm{d}x =
\left[ \frac{x^2}{2} \right]_{-2}^2 = \frac{4}{2} - \frac{4}{2} = 0}$ U.A.

Ce résultat est logique car l'aire au-dessus de la courbe de la fonction $f$ sur $[-2;0]$ est égale à l'aire sous la
courbe de $f$ sur $[0;2]$ (
voir [les propriétés sur les intégrales des fonctions impaires](#intégrales-de-fonctions-paires-et-impaires)).

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

<bubble variant="tip">

#### Exemple

On veut calculer $I = \displaystyle{\int_{-2}^4 f(x) \, \mathrm{d}x}$ où $f(x) = |x| = \begin{cases} -x \text{ si } x
\lt 0 \\ x \text{ si } x \geq 0 \end{cases}$.

**1<sup>ère</sup> étape :** On sépare l'intégrale à l'aide de la relation de Chasles :

$\displaystyle{I = \int_{-2}^{4} f(x) \, \mathrm{d}x = \int_{-2}^{0} -x \, \mathrm{d}x + \int_{0}^{4} x \,
\mathrm{d}x}$.

**2<sup>ème</sup> étape :** On calcule l'intégrale :

$\displaystyle{I = \int_{-2}^{0} -x \, \mathrm{d}x + \int_{0}^{4} x \, \mathrm{d}x = \left[ -\frac{x^2}{2} \right]_
{-2}^0 + \left[ \frac{x^2}{2} \right]_0^4 = 0 - (-\frac{2^2}{2}) + ((\frac{4^2}{2}) - 0) = 10}$ U.A.

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

<bubble variant="proof">

#### Intégration par parties

Comme $(u \times v)' = u'v + uv'$, on a que la fonction $u \times v$ est une primitive de la fonction $u'v + uv'$ sur
$I$. Or, par la relation de Chasles :

$\displaystyle{\int_a^b u'(x) v(x) + u(x) v'(x) \, \mathrm{d}x = \int_a^b u'(x) v(x) \, \mathrm{d}x + \int_a^b u(x) v'(
x) \, \mathrm{d}x}$

Donc, avec ce que l'on a fait au tout début, on a bien :

$\displaystyle{\int_a^b u'(x) v(x) \, \mathrm{d}x + \int_a^b u(x) v'(x) \, \mathrm{d}x = \left[u(x) v(x)\right]_a^b}$

C'est-à-dire :

$\displaystyle{\int_a^b u'(x) v(x) \, \mathrm{d}x = \left[u(x) v(x)\right]_a^b - \int_a^b u(x) v'(x) \, \mathrm{d}x}$

</bubble>

<bubble variant="tip">

#### Exemple

En utilisant cette technique, calculons $\displaystyle{I = \int_{0}^1 xe^x \, \mathrm{d}x}$. Nous souhaitons faire
disparaître le $x$, on va donc poser $u'(x) = e^x$ et $v(x) = x$ (afin de dériver $x$).

Donc par la formule d'intégration par parties :

$\displaystyle{I = \left[\underbrace{e^x}_{= u} \underbrace{x}_{= v}\right]_0^1 - \int_{0}^1 \underbrace{e^x}_{= u}
\times \underbrace{1}_{= v'} \, \mathrm{d}x = e - \left[ e^x \right]_0^1 = 1}$.

Il vous faudra un peu de pratique pour savoir quelle fonction il faut dériver et quelle fonction il faut primitiver.

</bubble>

### Intégrales de fonctions paires et impaires

<bubble variant="formula">

#### Intégrale d'une fonction paire

Soit $f$ une **fonction paire** continue sur un intervalle $I$ (comme $x \mapsto x^2$).

On a la relation suivante pour tout $a \in I$ ($-a$ doit aussi être dans $I$) :

$\displaystyle{\int_{-a}^{a} f(x) \, \mathrm{d}x = 2 \times \int_{0}^{a} f(x) \, \mathrm{d}x = 2 \times \int_{-a}^{0} f(
x) \, \mathrm{d}x}$.

</bubble>

<bubble variant="tip">

#### Exemple

Cette relation peut se retrouver visuellement, l'aire du côté gauche par rapport à $(Oy)$ est égale à l'aire de l'autre
côté de $(Oy)$, et les deux sont positives ; on peut donc les additionner pour retrouver l'aire totale :

<representation geogebra-id="bqha9q8p"></representation>

</bubble>

<bubble variant="formula">

#### Intégrale d'une fonction impaire

Soit $f$ une **fonction impaire** continue sur un intervalle $I$ (comme $x \mapsto x^3$).

On a la relation suivante pour tout $a \in I$ ($-a$ doit aussi être dans $I$) :

$\displaystyle{\int_{-a}^{a} f(x) \, \mathrm{d}x = 0}$.

</bubble>

<bubble variant="tip">

#### Exemple

De même, on peut retrouver cette relation visuellement, l'aire du côté gauche par rapport à $(Oy)$ est négative et égale
à l'aire de l'autre côté de $(Oy)$ qui est positive, les deux s'annulent donc :

<representation geogebra-id="jde5vc4m"></representation>

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

<bubble variant="proof">

#### Existence d'une primitive

Soit $F$ une autre primitive de $f$. Alors on a pour tout $x \in I$, $\displaystyle{F_a(x) = \int_a^x f(t) \,
\mathrm{d}t} = F(x) - F(a)$ par le théorème fondamental de l'analyse.

Donc pour tout $x \in I$, $F_a'(x) = F'(x) - 0 = f(x)$, donc on a bien que $F_a$ est une primitive de $f$.

De plus, $\displaystyle{F_a(a) = \int_{a}^{a} f(t) \, \mathrm{d}t = 0}$.

Enfin, comme les primitives d'une fonction continue sur un intervalle diffèrent d'une constante près, on a bien
l'unicité de $F_a$.

</bubble>
