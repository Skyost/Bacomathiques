## Le nombre $e$

Le **nombre d'Euler** $e$ (également appelé constante de Neper) est une constante mathématique irrationnelle qui possède
de nombreuses propriétés.

<bubble variant="formula">

#### Valeur approchée

Une valeur approchée de $e$ est $\approx 2,71828$.

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
