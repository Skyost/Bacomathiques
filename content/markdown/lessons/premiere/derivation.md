## Qu'est-ce-qu'une dérivée ?

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

#### Limite d'une fonction

La notation $\displaystyle{\lim\limits_{\substack{h \rightarrow 0}}}$ veut simplement dire que l'on rend $h$ aussi
proche de $0$ que possible (sans pour autant que $h$ soit égal à $0$). On dit que l'on fait tendre $h$ vers $0$ et on
appelle cela **une limite**.

**Attention !** Il arrive que cette limite n'existe pas ou ne soit pas finie. Dans ce cas-là $f'(a)$ n'existe pas et on
dit que $f$ n'est pas dérivable en $a$.

</bubble>

### La tangente

<bubble variant="formula">

#### Équation de la tangente

Soient $f$ une fonction définie sur un intervalle $I$ et un réel $a \in I$. Si $f$ est dérivable en $a$, alors la courbe
représentative de $f$ admet une tangente $\mathcal{T}$ au point de coordonnées $(a; f(a))$.

De plus, $f'(a)$ est le coefficient directeur de $\mathcal{T}$, et une équation de $\mathcal{T}$ est $y = f'(a)(x-a)+f(
a)$.

</bubble>

<representation geogebra-id="znryeret"></representation>

<bubble variant="proof">

#### Équation de la tangente

La tangente $\mathcal{T}$ en un point d'une courbe est une droite. Une équation de droite est de la forme $y = mx + p$
avec $m$ le coefficient directeur et $p$ l'ordonnée à l'origine.

On a déjà le coefficient directeur de $\mathcal{T}$ par la propriété précédente : $m = f'(a)$.

De plus, on sait que $\mathcal{T}$ passe par le point $(a, f(a))$ (car c'est la tangente à $\mathcal{C}_f$ au point
d'abscisse $a$).

Donc l'équation de droite vérifie $f(a) = f'(a)a + p$. Ce qui donne $p = f(a) - af'(a)$.

Au final notre équation est la suivante : $y = xf'(a) + f(a) - af'(a) \iff y = f(a) + (x - a)f'(a)$.

</bubble>

### Fonction dérivée

<bubble variant="formula">

#### Définition

Soit $f$ une fonction dérivable sur un intervalle $I$ de $\mathbb{R}$.

On appelle fonction dérivée (ou plus simplement **dérivée**) de $f$ la fonction $g$ qui à tout réel $x$ de $I$, associe
le nombre dérivé $f'(x)$ (i.e. $g(x) = f'(x)$).

</bubble>

Très souvent, la fonction $g$ sera notée $f'$.

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
| $\sin(x)$                       | $\cos(x)$                            | $\mathbb{R}$            |
| $\cos(x)$                       | $-\sin(x)$                           | $\mathbb{R}$            |

</bubble>

### Opérations sur les dérivées

Le tableau suivant est également à connaître et nous donne la dérivée qui dépend des opérations sur certaines
fonctions :

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

Le tableau suivant, toujours à connaître, nous donne la dérivée des fonctions composées usuelles (i.e. $f$ de $g$ de
$x$) :

<bubble variant="formula">

Soit $u$ une fonction.

| Fonction                        | Dérivée                               | Domaine de dérivabilité                                     |
| ------------------------------- | ------------------------------------- | ----------------------------------------------------------- |
| $u^n$ avec $n \in \mathbb{N}^*$ | $nu'u^{n-1}$                          | En tout point où $u$ est dérivable.                         |
| $\displaystyle{\frac{1}{u}}$    | $\displaystyle{-\frac{u'}{u^2}}$      | En tout point où $u$ est dérivable et non nulle.            |
| $\sqrt{u}$                      | $\displaystyle{\frac{u'}{2\sqrt{u}}}$ | En tout point où $u$ est dérivable et strictement positive. |
| $e^u$                           | $u'e^u$                               | En tout point où $u$ est dérivable.                         |
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

## Étude des variations d'une fonction

### Lien dérivée - variations d'une fonction

Avec le signe de la dérivée d'une fonction, il est possible d'obtenir le sens de variation de cette fonction.

<bubble variant="formula">

#### Variations d'une fonction

Soit une fonction $f$ dérivable sur un intervalle $I$.

* Si $f' \gt 0$ sur $I$, alors $f$ est strictement croissante sur $I$.
* Si $f' \lt 0$ sur $I$, alors $f$ est strictement décroissante sur $I$.
* Si $f' = 0$ sur $I$, alors $f$ est constante sur $I$.

</bubble>

<representation geogebra-id="sjeph3eh"></representation>

### Extrema

<bubble variant="formula">

#### Étude des extrema

Soient $f$ dérivable sur un intervalle $I$, et $a \in I$ :

* Si $f$ admet un extremum local en $a$, alors on a $f'(a) = 0$.
* Si $f'(a) = 0$ et que le signe de $f'$ est différent avant et après $a$, alors $f'(a)$ est un extremum local de $f$.
* Si $f'(a) = 0$ et qu'on est négatif avant $a$ et positif après, cet extremum local est un minimum local.
* Si $f'(a) = 0$ et qu'on est positif avant $a$ et négatif après, cet extremum local est un maximum local.

</bubble>

<bubble variant="tip">

Avec ceci, il est possible de retrouver la plupart des formules que nous avons vues sur
les [fonctions du second degré](/cours/premiere/polynomes-second-degre/) (sens de variation, sommet de la parabole, ...).

</bubble>
