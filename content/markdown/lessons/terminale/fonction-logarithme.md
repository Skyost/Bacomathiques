## Propriétés du logarithme népérien

### Définition

<bubble variant="formula">

#### Définition

Le **logarithme népérien** est une fonction qui est définie sur $]0;+\infty[$ par $x \mapsto \ln(x)$.

</bubble>

<bubble variant="formula">

On a la relation fondamentale suivante pour tout $x \gt 0$ et $y$ réels :

$\ln(x) = y \iff x = e^y$.

</bubble>

Ainsi, a tout réel **strictement positif** $x$, la fonction logarithme népérien y associe **son unique antécédent** $y$
par rapport à [la fonction exponentielle](/cours/premiere/fonction-exponentielle/). De même pour la fonction
exponentielle.

On dit que ces fonctions sont des **fonctions réciproques** (à la manière de $\sin$ et $\arcsin$ ou $\cos$ et $\arccos$)
.

<bubble variant="tip">

#### Exemple

Cette relation peut sembler compliquer à assimiler mais il n'en est rien ! Prenons $x = 0$, on a :

$e^0 = 1$ (tout réel mis à la puissance zéro vaut un), la relation précédente nous donne $\ln(1) = 0$.

Si on prend maintenant $x = 1$, on a :

$e^1 = e$, on a donc $\ln(e) = 1$.

</bubble>

Les relations suivantes sont par conséquent disponibles :

<bubble variant="formula">

#### Relations entre fonctions réciproques

Pour tout réel $x$ **strictement positif**, on a $e^{\ln(x)} = x$.

Et pour tout réel $x$, on a $\ln(e^x) = x$.

</bubble>

### Relations algébriques

Le logarithme népérien a plusieurs propriétés intéressantes qu'il faut connaître.

<bubble variant="formula">

#### Formules

Pour tous réels $x$ et $y$ **strictement positifs** :

* $\ln(x \times y) = \ln(x) + \ln(y)$
* $\ln(x^n) = n \times \ln(x)$ pour $n \in \mathbb{Z}$
* $\displaystyle{\ln\left(\frac{x}{y}\right) = \ln(x) - \ln(y)}$
* $\displaystyle{\ln\left(\frac{1}{y}\right) = -\ln(y)}$
* $\displaystyle{\ln(\sqrt[p]{x}) = \frac{1}{p} \times \ln(x)}$ pour $p \in \mathbb{N}^*$

</bubble>

Certaines de ces propriétés peuvent se déduire les unes des autres.

### Représentation graphique

Voici une représentation graphique de la fonction logarithme népérien :

<representation geogebra-id="wsntfeab"></representation>

On voit sur ce graphique plusieurs propriétés données précédemment : $\ln(1) = 0$ et $\ln(e) = 1$ par exemple.

On trace maintenant le graphe de la fonction logarithme népérien, avec celui de la fonction exponentielle. On trace
également la droite d'équation $y = x$ :

<representation geogebra-id="aymmb94w"></representation>

On remarque plusieurs choses : le graphe de la fonction logarithme népérien est le symétrique de celui de la fonction
exponentielle par rapport à la

droite $y = x$ et on voit que la fonction logarithme népérien croît moins vite que la fonction puissance qui elle-même
croît moins vite que la fonction exponentielle. Cette propriété est importante : c'est la **croissance comparée**.

## Étude de la fonction

### Limites

<bubble variant="formula">

#### Limites

Les limites de la fonction logarithme népérien aux bornes de son ensemble de définition sont :

* $\lim_{x \rightarrow 0^+} \ln(x) = -\infty$
* $\lim_{x \rightarrow +\infty} \ln(x) = +\infty$

</bubble>

Il faut aussi savoir que la fonction puissance l'emporte sur le logarithme népérien (voir la
partie [Représentation graphique](#représentation-graphique)).

<bubble variant="formula">

#### Croissances comparées

Pour tout $n \in \mathbb{N}$ :

* $\displaystyle{\lim_{x \rightarrow +\infty} \frac{\ln(x)}{x^n} = 0}$.
* $\displaystyle{\lim_{x \rightarrow 0^+} x^n \ln(x) = 0}$.

</bubble>

<bubble variant="proof">

#### Croissances comparées

Nous allons démontrer le second point en utilisant le premier (qui n'est pas éligible à une démonstration au lycée) dans
le cas $n = 1$. Pour tout $x \gt 0$, posons $y = \frac{1}{x}$.

On a donc pour tout, $x \ln(x) = \frac{1}{y} \ln\left(\frac{1}{y}\right) = -\frac{\ln(y)}{y}$.

Or, quand $x$ tend vers $0^+$, $y$ tend vers $+\infty$. Par le premier point :

$\displaystyle{\lim\limits_{\substack{y \rightarrow +\infty}} \frac{\ln(y)}{y} = 0 \iff \lim\limits_{\substack{y
\rightarrow +\infty}} -\frac{\ln(y)}{y} = 0}$.

Et en remplaçant $y$ par $\frac{1}{x}$ dans le résultat ci-dessus, on a bien ce que l'on cherchait.

</bubble>

Pour finir, on donne une limite qu'il peut être utile de savoir redémontrer.

<bubble variant="formula">

$\displaystyle{\lim\limits_{\substack{x \rightarrow 0}} \frac{\ln(1 + x)}{x} = 1}$

</bubble>

<bubble variant="proof">

La fonction logarithme népérien est dérivable en $1$ (voir sous-section suivante), on peut donc écrire :

$\displaystyle{\ln'(1) = \lim\limits_{\substack{x \rightarrow 1}} \frac{\ln(x) - \ln(1)}{x - 1}}$

Ce qui est équivalent à (car on a $\ln(1) = 0$ et $\ln'(1) = 1$) :

$\displaystyle{1 = \lim\limits_{\substack{x \rightarrow 1}} \frac{\ln(x)}{x - 1}}$

On pose $y = x-1$ ce qui nous donne finalement :

$\displaystyle{\lim\limits_{\substack{y \rightarrow 0}} \frac{\ln(y - 1)}{y} = 1}$

</bubble>

### Dérivée

<bubble variant="formula">

#### Dérivée d'une composée

Soit une fonction $u$ dérivable et **strictement positive** sur un intervalle $I$, on a pour tout $x$ appartenant à cet
intervalle :

$\displaystyle{\ln'(u(x)) = \frac{u'(x)}{u(x)}}$.

</bubble>

<bubble variant="formula">

#### Dérivée

Ainsi, si pour tout $x \in I$ on a $u(x) = x$, on trouve :

$\displaystyle{\ln'(x) = \frac{1}{x}}$.

</bubble>

### Variations

Avec la dérivée donnée précédemment ainsi que les limites données, il est désormais possible d'obtenir les variations de
la fonction logarithme népérien.

<bubble variant="formula">

#### Signe et variations

![Tableau de variations de la fonction logarithme](/img/lessons/terminale/fonction-logarithme/variations.svg)

On remarque qu'avec le tableau de variation, il est possible d'obtenir le signe de la fonction (avec le théorème des
valeurs intermédiaires).

Ainsi, sur $]0;1[$, $\ln$ est **strictement négative** et sur $]1;+\infty[$, $\ln(x)$ est **strictement positive** et,
comme vu précédemment, $\ln(1) = 0$.

On observe également les variations de la fonction : strictement croissante sur son ensemble de définition.

</bubble>
