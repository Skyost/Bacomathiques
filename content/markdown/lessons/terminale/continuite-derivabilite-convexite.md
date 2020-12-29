## Continuité

### Définition

<bubble variant="formula">

#### Définition

Soient $f$ une fonction définie sur un intervalle $I$ et un réel $a \in I$. La fonction $f$ est continue en $a$ si on a
$\lim\limits_{\substack{x \rightarrow a}} f(x) = f(a)$.

$f$ est dite **continue** sur $I$, si on peut appliquer la formule ci-dessus à tous les réels de l'intervalle $I$.

</bubble>

On dit de manière générale qu'une fonction est continue sur un intervalle s'il est possible de tracer sa courbe
représentative sur cet intervalle sans lever le crayon.

<bubble variant="formula">

#### Opérations sur les fonctions continues

* Toute somme, produit, composée ou quotient (avec le dénominateur ne s'annulant pas) de fonctions continues est
  également continue sur le même intervalle.
* Toute fonction dérivable sur un intervalle est continue sur cet intervalle (la réciproque n'est pas vraie cependant).

</bubble>

<bubble variant="tip">

#### Exemple

La fonction $x \mapsto \frac{1}{x}$ est continue en tout point de son ensemble de définition ($\mathbb{R}^*$) mais n'est
pas continue sur $\mathbb{R}$.

</bubble>

### Théorème des valeurs intermédiaires

<bubble variant="formula">

#### Théorème des valeurs intermédiaires

Si une fonction $f$ est continue sur un intervalle $[a;b]$, alors pour tout réel $y_0$ tel que $f(a) \lt y_0 \lt f(b)$ (
ou $f(a) \gt y_0 \gt f(b)$), il existe **au moins** un réel $x_0 \in [a;b]$ tel que $f(x_0) = y_0$.

</bubble>

<bubble variant="tip">

#### Exemple

Ce théorème est **très important** ! Voici un exemple : soit $f$ définie pour tout $x \in \mathbb{R}$ par $f(x) =
x^3+x^2-x$. Prouvons qu'il existe au moins un réel $x_0 \in [0;3]$ tel que $f(x_0) = 5$. On a $f(0) = 0$ et $f(3) = 33$.
D'après le théorème des valeurs intermédiaires, comme $f$ est continue sur $[0;3]$ et que $0 \lt 5 \lt 33$, il existe un
réel $x_0 \in [0,3]$ tel que $f(x_0) = 5$.

On peut encore tenter d'affiner la précision : $f(1) = 1$ et $f(2) = 10$. On a bien $1 \lt 5 \lt 10$ donc $x_0 \in [1;2]
$, etc.

</bubble>

<bubble variant="tip">

Une conséquence de ce théorème est que si $f(a)$ et $f(b)$ sont de signes opposés, alors la fonction $f$ s'annule au
moins une fois entre $a$ et $b$.

</bubble>

Enfin, il existe un corollaire qui donne en plus **l'unicité** du point $x_0$.

<bubble variant="formula">

#### Corollaire

Si $f$ est continue sur $[a;b]$ et que $f$ est **strictement monotone** sur cet intervalle, alors pour tout réel $y_0$
tel que $f(a) \lt y_0 \lt f(b)$ (ou $f(a) \gt y_0 \gt f(b)$), il existe **un unique** réel $x_0 \in [a;b]$ tel que $f(
x_0) = y_0$.

</bubble>

### La partie entière $[x]$

<bubble variant="formula">

#### Définition

Soit $x \in \mathbb{R}$. La **partie entière** de $x$ notée $[x]$ (ou $E(x)$) est l'unique réel tel que : $[x] \leq x
\lt [x] + 1$.

</bubble>

<bubble variant="tip">

#### Exemple

$[1,216] = 1$ et $[-2,198] = -3$.

</bubble>

La fonction partie entière définie par $x \mapsto [x]$ **n'est pas continue** sur $\mathbb{R}$ :

<representation geogebra-id="cpzeryjp"></representation>

## Dérivation

### Nombre dérivé

<bubble variant="formula">

#### Définition

Soient $f$ une fonction définie sur un intervalle $I$ et deux réels $a \in I$ et $h \neq 0$ tels que $(a + h) \in I$.

La fonction $f$ est **dérivable** en $a$ si la limite ci-dessous existe et est finie :

$\displaystyle{\lim\limits_{\substack{h \rightarrow 0}} \frac{f(a + h) - f(a)}{h}}$

Ou en posant $x = a + h$ :

$\displaystyle{\lim\limits_{\substack{x \rightarrow a}} \frac{f(x) - f(a)}{x-a}}$

Si cette limite existe et est finie, alors elle est égale au **nombre dérivé** de $f$ en $a$, noté $f'(a)$.

</bubble>

<bubble variant="tip">

#### Remarque

Notez bien que toute fonction dérivable en un point est continue en ce point.

</bubble>

### La tangente

<bubble variant="formula">

#### Équation de la tangente

Soient $f$ une fonction définie sur un intervalle $I$ et un réel $a \in I$. Si $f$ est dérivable en $a$, alors la courbe
représentative de $f$ admet une tangente $\mathcal{T}$ au point de coordonnées $(a; f(a))$.

De plus, $f'(a)$ est le coefficient directeur de $\mathcal{T}$, et une équation de $\mathcal{T}$ est $y = f'(a)(x-a)+f(
a)$.

</bubble>

<bubble variant="tip">

#### Exemple

Soit $f(x) = e^x$ définie sur $\mathbb{R}$ (voir cours
sur [la fonction exponentielle](/cours/premiere/fonction-exponentielle/)).

Cherchons une équation de la tangente au point d'abscisse $x = 0$ :

On a $f'(x) = f(x)$ donc $f'(0) = 1$.

Par conséquent, une équation de la tangente est $y = f'(0)(x-0)+f(0) = x + 1$ : on retrouve ce qui a été constaté
sur [la représentation graphique](/cours/premiere/fonction-exponentielle/) de la fonction exponentielle.

</bubble>

<representation geogebra-id="znryeret"></representation>

### Fonction dérivée

<bubble variant="formula">

#### Définition

Soit $f$ une fonction dérivable sur un intervalle $I$.

On appelle fonction dérivée (ou plus simplement **dérivée**) de $f$ la fonction $g$ qui à tout réel $x$ de $I$, associe
le nombre dérivé $f'(x)$ (i.e. $g(x) = f'(x)$).

</bubble>

Très souvent, la fonction $g$ sera notée $f'$.

### Applications

Plusieurs applications peuvent être trouvées aux dérivées. Avec le signe de la dérivée d'une fonction, il est possible
d'obtenir le sens de variation de cette fonction.

<bubble variant="formula">

#### Variations d'une fonction

Soit une fonction $f$ dérivable sur un intervalle $I$.

* Si $f' \gt 0$ sur $I$, alors $f$ est strictement croissante sur $I$.
* Si $f' \lt 0$ sur $I$, alors $f$ est strictement décroissante sur $I$.
* Si $f' = 0$ sur $I$, alors $f$ est constante sur $I$.

</bubble>

<representation geogebra-id="sjeph3eh"></representation>

Il est également possible d'en déduire diverses propriétés sur les extrema dits locaux (sur un certain intervalle) d'une
fonction.

<bubble variant="formula">

#### Étude des extrema

Soient $f$ dérivable sur un intervalle $I$, et $a \in I$ :

* Si $f$ admet un extremum local en $a$, alors on a $f'(a) = 0$.
* Si $f'(a) = 0$ et que le signe de $f'$ est différent avant et après $a$, alors $f'(a)$ est un extremum local de $f$.
* Si $f'(a) = 0$ et qu'on est négatif avant $a$ et positif après, cet extremum local est un minimum local.
* Si $f'(a) = 0$ et qu'on est positif avant $a$ et négatif après, cet extremum local est un maximum local.

</bubble>

## Tables de dérivation

### Dérivées usuelles

Le tableau suivant est à connaître et nous donne la dérivée de la plupart des fonctions usuelles :

<bubble variant="formula">

Soit $\lambda$ une constante réelle.

| Fonction                        | Dérivée                              | Domaine de dérivabilité |
| ------------------------------- | ------------------------------------ | ----------------------- |
| $\lambda$                       | $0$                                  | $\mathbb{R}$            |
| $x^n$ avec $n \in \mathbb{N}^*$ | $nx^{n-1}$                           | $\mathbb{R}$            |
| $\displaystyle{\frac{1}{x}}$    | $\displaystyle{-\frac{1}{x^2}}$      | $\mathbb{R}^*$          |
| $\sqrt{x}$                      | $\displaystyle{\frac{1}{2\sqrt{x}}}$ | $\mathbb{R}^+_*$        |
| $e^x$                           | $e^x$                                | $\mathbb{R}$            |
| $\ln(x)$                        | $\frac{1}{x}$                        | $\mathbb{R}^+_*$        |
| $\sin(x)$                       | $\cos(x)$                            | $\mathbb{R}$            |
| $\cos(x)$                       | $-\sin(x)$                           | $\mathbb{R}$            |

</bubble>

### Opérations sur les dérivées

Le tableau suivant est également à connaître et nous donne la dérivée qui dépend des opérations sur les fonctions $u$ et
$v$ :

<bubble variant="formula">

Soient deux fonctions $u$ et $v$ et soit $\lambda$ une constante réelle.

| Fonction                     | Dérivée                                 | Domaine de dérivabilité                                    |
| ---------------------------- | --------------------------------------- | ---------------------------------------------------------- |
| $\lambda \times u$           | $\lambda \times u'$                     | En tout point où $u$ est dérivable.                        |
| $u + v$                      | $u' + v'$                               | En tout point où $u$ et $v$ sont dérivables.               |
| $u \times v$                 | $u' \times v + u \times v'$             | En tout point où $u$ et $v$ sont dérivables.               |
| $\displaystyle{\frac{1}{v}}$ | $\displaystyle{-\frac{v'}{v^2}}$        | En tout point où $v$ est dérivable et non nulle.           |
| $\displaystyle{\frac{u}{v}}$ | $\frac{u' \times v - u \times v'}{v^2}$ | En tout point où $u$ et $v$ sont dérivables et non nulles. |

</bubble>

### Dérivées de composées

Le tableau suivant, toujours à connaître, nous donne la dérivée des fonctions composées usuelles :

<bubble variant="formula">

Soit $u$ une fonction.

| Fonction                        | Dérivée                               | Domaine de dérivabilité                                     |
| ------------------------------- | ------------------------------------- | ----------------------------------------------------------- |
| $u^n$ avec $n \in \mathbb{N}^*$ | $nu'u^{n-1}$                          | En tout point où $u$ est dérivable.                         |
| $\displaystyle{\frac{1}{u}}$    | $\displaystyle{-\frac{u'}{u^2}}$      | En tout point où $u$ est dérivable et non nulle.            |
| $\sqrt{u}$                      | $\displaystyle{\frac{u'}{2\sqrt{u}}}$ | En tout point où $u$ est dérivable et strictement positive. |
| $e^u$                           | $u'e^u$                               | En tout point où $u$ est dérivable.                         |
| $\ln(u)$                        | $\frac{u'}{u}$                        | En tout point où $u$ est dérivable et strictement positive. |
| $\sin(u)$                       | $u'\cos(u)$                           | En tout point où $u$ est dérivable.                         |
| $\cos(u)$                       | $-u'\sin(u)$                          | En tout point où $u$ est dérivable.                         |

</bubble>

Il est cependant possible de donner une formule plus générale.

<bubble variant="formula">

#### Dérivée d'une composée

Soient $f$ dérivable sur $I$ et $g$ dérivable sur l'ensemble des valeurs prises par $f$ sur $I$. On a alors $(g \circ
f)' = (g' \circ f) \times f'$.

</bubble>

<bubble variant="tip">

#### Fonction composée

On rappelle que la fonction $g \circ f$ est la fonction définie pour tout $x$ par $(g \circ f)(x) = g(f(x))$.

</bubble>

## Convexité

### Dérivée seconde d'une fonction

<bubble variant="formula">

#### Définition

Soit $f$ une fonction dérivable sur un intervalle $I$, de dérivée $f'$ dérivable sur $I$.

On appelle **dérivée seconde** (notée $f''$) de $f$, la fonction dérivée de $f'$.

</bubble>

Ainsi, pour calculer $f''$, on calcule d'abord $f'$, puis on dérive $f'$.

<bubble variant="tip">

#### Exemple

Soit $f$ la fonction définie pour tout $x \in \mathbb{R}$ par $f(x) = \sin(2x)$. Calculons $f''$.

On applique la formule pour dérivée $\sin(u)$ (où $u$ est la fonction $u : x \mapsto 2x$) :

Pour tout $x \in \mathbb{R}$, $f'(x) = u' \cos(u) = 2 \cos(2x)$.

Pour finir, il suffit juste de dériver $f'$ : pour tout $x \in \mathbb{R}$, $f''(x) = 2 \times (-2 \sin(2x)) = -4 \sin(
2x)$.

</bubble>

### Fonction convexe

<bubble variant="formula">

#### Définition

Soit $f$ une fonction dérivable sur un intervalle $I$, de dérivée $f'$ dérivable sur $I$.

* On dit que $f$ est **convexe** sur $I$ si $f''$ est positive sur $I$.
* On dit que $f$ est **concave** sur $I$ si $f''$ est négative sur $I$.
* On dit que $a \in I$ est un **point d'inflexion** si $f''$ change de signe en $a$ (i.e. $f''(a) = 0$ et $f''$ est
  positive avant $a$ puis négative après ou inversement).

</bubble>

<bubble variant="tip">

Dire que $f''$ est positive sur $I$ revient à dire que $f'$ est croissante sur $I$. De même, dire que $f''$ est négative
sur $I$ revient à dire que $f'$ est décroissante sur $I$.

</bubble>

### Lien avec les tangentes

<bubble variant="formula">

#### Lien avec la représentation graphique

Soit $f$ une fonction dérivable sur un intervalle $I$, de dérivée $f'$ dérivable sur $I$. On note $\mathcal{C}_f$ la
courbe représentative de $f$.

* $f$ est **convexe** sur $I$ si $\mathcal{C}_f$ est au-dessus de chacune de ses tangentes sur $I$.
* $f$ est **concave** sur $I$ si $\mathcal{C}_f$ est en dessous de chacune de ses tangentes sur $I$.

</bubble>

<representation geogebra-id="v74xn9rx"></representation>

<bubble variant="tip">

#### Exemple

À titre d'exemple, la fonction exponentielle est une fonction convexe.

</bubble>
