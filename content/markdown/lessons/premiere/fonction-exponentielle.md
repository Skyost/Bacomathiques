## Le nombre $e$

Le **nombre d'Euler** $e$ (également appelé constante de Neper) est une constante mathématique irrationnelle qui possède
de nombreuses propriétés.

<bubble variant="formula">

#### Valeur approchée

Une valeur approchée de $e$ est $\approx 2,71828$.

</bubble>

Cependant, une définition plus exacte de $e$ existe.

<bubble variant="formula">

#### Autre définition

On définit la suite $(e_n)$ pour tout $n \in \mathbb{N}$ par $\displaystyle{e_n = \left(1 + \frac{1}{n}\right)^n}$.

Alors la limite de la suite $(e_n)$ quand $n$ tend vers $+\infty$ est $e$.

</bubble>

<bubble variant="tip">

Grâce à cette définition, il est plus facile de construire un algorithme pour approximer $e$.

</bubble>

## La fonction exponentielle

### Définition

<bubble variant="formula">

#### Définition

La fonction exponentielle notée pour tout $x \in \mathbb{R}$ par $e^x$ (ou parfois $\exp(x)$) est l'unique fonction $f$
définie sur $\mathbb{R}$ remplissant les critères suivants :

* $f$ est dérivable sur $\mathbb{R}$ et $f'$ = $f$
* $f \gt 0$ sur $\mathbb{R}$
* $f(0) = 1$

</bubble>

<bubble variant="proof">

#### Existence

**L'existence** de cette fonction est admise, il faut cependant en démontrer **l'unicité**.

Soit une autre fonction $g$ vérifiant les mêmes propriétés que notre fonction $f$. On pose pour tout $x \in \mathbb{R}$,
$h(x) = \frac{f(x)}{g(x)}$.

Comme $g$ ne s'annule pas et que $h$ est un quotient de fractions dérivables ne s'annulant pas sur $\mathbb{R}$, $h$ est
dérivable sur $\mathbb{R}$.

D'où, pour tout $x \in \mathbb{R}$, $h'(x) = \frac{f'(x)g(x) - f(x)g'(x)}{g(x)^2} = 0$ (car $f = f'$ et $g = g'$).

On a donc $h$ constante sur $\mathbb{R}$ et la valeur de $h$ est $h(0) = \frac{f(0)}{g(0)} = 1$.

Pour tout $x \in \mathbb{R}$, $h(x) = 1 \iff \frac{f(x)}{g(x)} = 1 \iff f(x) = g(x)$. Donc $g = f$.

</bubble>

<bubble variant="tip">

#### Formules

La fonction exponentielle, telle qu'on l'a écrite, est composée d'un réel ($e \approx 2,718 $) et d'un exposant réel
$x$. **Les opérations sur les exposants** sont disponibles, par exemple, pour tout $x$, $y \in \mathbb{R}$ :

* $e^{x+y} = e^x \times e^y$
* $e^{x-y} = \displaystyle{\frac{e^x}{e^y}}$
* $e^{-x} = \displaystyle{\frac{1}{e^x}}$
* $(e^x)^y = e^{x \times y}$

Et bien entendu, $e^0 = 1$.

</bubble>

### Relations algébriques

<bubble variant="formula">

#### Relations algébriques

La fonction exponentielle a plusieurs propriétés algébriques qu'il faut connaître. Ainsi, pour tous réels $x$ et $y$ :

* $e^x = e^y \iff x = y$
* $e^x \lt e^y \iff x \lt y$

</bubble>

### Représentation graphique

Voici une représentation graphique de la fonction exponentielle (courbe bleue) et de sa tangente au point d'abscisse
$0$ :

<representation geogebra-id="d62ctre4"></representation>

On voit plusieurs propriétés données précédemment : $e^0 = 1$, $e \approx 2,718$, etc. Mais également d'autres
propriétés que nous verrons par la suite comme le fait que la fonction soit **strictement positive** sur $\mathbb{R}$. À
noter que la **tangente** à sa courbe représentative en $x = 0$ est $y = x + 1$.

<bubble variant="tip">

#### Représentation d'une fonction exponentielle

Il peut être utile de savoir représenter une courbe d'une fonction du type $x \mapsto e^{kx}$ avec $k \in \mathbb{R}$ :

* L'image de $0$ par ces fonctions est toujours $1$.
* Plus $k$ est grand, plus la croissance est forte et rapide.
* Si $k$ est négatif, la courbe est symétrique à celle de $x \mapsto e^{-kx}$ par rapport à l'axe des ordonnées.

</bubble>

## Étude de la fonction

### Dérivée

<bubble variant="formula">

#### Dérivée d'une composée

Soit une fonction $u$ dérivable sur un intervalle $I$, on a pour tout $x$ appartenant à cet intervalle : $(e^{u(x)})' =
u'(x)e^{u(x)}$.

</bubble>

<bubble variant="formula">

#### Dérivée

Ainsi, si pour tout $x \in I$ on a $u(x) = x$, on retrouve : $({e^x})' = e^x$.

</bubble>

Cette propriété a été donnée dans la section [Définition](#définition).

### Variations

Avec la dérivée donnée précédemment, il est désormais possible d'obtenir les variations de la fonction exponentielle.

<bubble variant="formula">

#### Variations

![Tableau de variations de la fonction exponentielle](/img/lessons/premiere/fonction-exponentielle/variations.svg)

On remarque sur le tableau de variation que la fonction exponentielle est strictement positive et croissante sur
$\mathbb{R}$.

</bubble>

### La suite $(e^{na})$

<bubble variant="formula">

Soit $a \in \mathbb{R}$. La suite $(e^{na})$ est une suite géométrique de raison $e^a$ et de premier terme $1$.

</bubble>

<bubble variant="proof">

Posons pour tout $n \in \mathbb{N}$, $u_n = e^{na}$.

Calculons $u_{n+1}$ :

$u_{n+1} = e^{(n+1)a} = e^{na} \times e^a = u_n \times e^a$.

Et on a bien $u_0 = e^0 = 1$.

</bubble>
