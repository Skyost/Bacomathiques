## Limite d'une fonction en un point

### Limite infinie

<bubble variant="formula">

#### Fonction tendant vers $+\infty$ en un point

Soit $f$ une fonction (en classe de Terminale, on se limite aux fonctions réelles) d'ensemble de définition
$\mathcal{D}_f$. Soit $a$ un réel appartenant à $\mathcal{D}_f$ ou étant une borne de $\mathcal{D}_f$.

On dit que $f(x)$ **tend vers $+\infty$** quand $x$ tend vers $a$ si $f(x)$ est aussi grand que l'on veut pourvu que $x$
soit suffisamment proche de $a$.

On note ceci $\lim_{x \rightarrow a} f(x) = +\infty$.

</bubble>

<bubble variant="tip">

#### Exemple

La fonction $f$ définie sur $\mathbb{R}^*$ par $f(x) = \frac{1}{x^2}$, tend vers $+\infty$ quand $x$ tend vers $0$.

<representation geogebra-id="wkysdds8"></representation>

</bubble>

Il est tout à fait possible d'établir une définition similaire pour une fonction tendant vers $-\infty$ en un point.

<bubble variant="tip">

#### Fonction tendant vers $-\infty$ en un point

En reprenant les notations précédentes, on dit que $f(x)$ **tend vers $-\infty$** quand $x$ tend vers $a$ si $f(x)$ est
aussi petit que l'on veut pourvu que $x$ suffisamment proche de $a$.

On note ceci $\lim_{x \rightarrow a} f(x) = -\infty$.

</bubble>

<bubble variant="tip">

#### Exemple

La fonction $f$ définie sur $]-\infty, 3[ \, \cup \, ]3, +\infty[$ par $f(x) = -\frac{1}{x^2-6x+9}$, tend vers $-\infty$
quand $x$ tend vers $3$.

<representation geogebra-id="fu58s6je"></representation>

</bubble>

### Limite finie

<bubble variant="formula">

#### Définition

Soit $f$ une fonction d'ensemble de définition $\mathcal{D}_f$. Soit $a$ un réel appartenant à $\mathcal{D}_f$ ou étant
une borne de $\mathcal{D}_f$.

On dit que $f(x)$ **tend vers $\ell$** quand $x$ tend vers $a$ si $f(x)$ est aussi proche de $\ell$ que l'on veut pourvu
que $x$ soit suffisamment proche de $a$.

On note ceci $\lim_{x \rightarrow a} f(x) = \ell$.

</bubble>

<bubble variant="tip">

#### Exemple

La fonction $f$ définie sur $\mathbb{R}^*$ par $f(x) = \frac{\sin(x)}{x}$, tend vers $1$ quand $x$ tend vers $0$.

<representation geogebra-id="fq28tqng"></representation>

Une petite remarque cependant : cette limite n'est pas triviale à démontrer. On peut cependant en proposer une preuve à
l'aide de la dérivée de la fonction $\sin$ (qui est $\cos$) : $\lim_{x \rightarrow 0} \frac{\sin(x)}{x} = \lim_{x
\rightarrow 0} \frac{\sin(x) - \sin(0)}{x - 0} = \sin'(0) = \cos(0) = 1$.

</bubble>

### Limites à gauche et à droite

<bubble variant="formula">

#### Définition

Soit $f$ une fonction d'ensemble de définition $\mathcal{D}_f$. Soit $a$ un réel appartenant à $\mathcal{D}_f$ ou étant
une borne de $\mathcal{D}_f$.

* On dit que $f(x)$ admet une **limite à gauche** quand $x$ tend vers $a$ si $f(x)$ admet une limite quand $x$ tend vers
  $a$ avec $x \lt a$. On la note $\lim_{x \rightarrow a^-} f(x)$.
* On dit que $f(x)$ admet une **limite à droite** quand $x$ tend vers $a$ si $f(x)$ admet une limite quand $x$ tend vers
  $a$ avec $x \gt a$. On la note $\lim_{x \rightarrow a^+} f(x)$.

</bubble>

<bubble variant="tip">

#### Exemple

La fonction $f$ définie sur $\mathbb{R}^*$ par $f(x) = \frac{1}{x}$, admet deux limites différentes à gauche et à droite
de $0$ :

* $\lim_{x \rightarrow 0^-} h(x) = -\infty$
* $\lim_{x \rightarrow 0^+} h(x) = +\infty$

<representation geogebra-id="p5pedmuw"></representation>

</bubble>

### Asymptote verticale

<bubble variant="formula">

#### Définition

Soit $f$ une fonction d'ensemble de définition $\mathcal{D}_f$. Soit $a$ un réel appartenant à $\mathcal{D}_f$ ou étant
une borne de $\mathcal{D}_f$.

Alors si $f(x)$ admet une limite infinie quand $x$ tend vers $a$, alors la droite d'équation $x = a$ est une **asymptote
verticale** à la courbe représentative de $f$.

</bubble>

<bubble variant="tip">

#### Exemple

En reprenant les exemples précédents :

* Les courbes représentatives des fonctions $x \mapsto \frac{1}{x}$ et $x \mapsto \frac{1}{x^2}$ admettent toutes deux
  une asymptote verticale d'équation $x = 0$.
* La courbe de la fonction $x \mapsto \frac{1}{x^2-6x+9}$ admet une asymptote verticale d'équation $x = 3$.

</bubble>

## Limite d'une fonction en l'infini

### Limite infinie

<bubble variant="formula">

#### Fonction tendant vers $+\infty$ en $+\infty$

Soit $f$ une fonction d'ensemble de définition $\mathcal{D}_f$. On suppose qu'une des bornes de $\mathcal{D}_f$ est
$+\infty$.

On dit que $f(x)$ **tend vers $+\infty$** si $f(x)$ est aussi grand que l'on veut pourvu que $x$ soit suffisamment
grand.

</bubble>

Comme précédemment, on peut écrire des définitions similaires pour dire que $f$ tend vers $-\infty$ quand $x$ tend vers
$+\infty$.

<bubble variant="tip">

#### Fonction tendant vers $-\infty$ en $+\infty$

En reprenant les notations précédentes, on dit que $f(x)$ **tend vers $-\infty$** quand $x$ tend vers $+\infty$ si $f(x)
$ est aussi petit que l'on veut pourvu que $x$ soit suffisamment grand.

</bubble>

<bubble variant="tip">

#### Fonction tendant vers $\pm \infty$ en $-\infty$

Pour avoir les définitions quand $x$ tend vers $-\infty$, il suffit de remplacer $x$ suffisamment grand par $x$
suffisamment petit et il faut qu'une des bornes de $\mathcal{D}_f$ soit $-\infty$.

</bubble>

<bubble variant="tip">

#### Exemple

La fonction $f$ définie sur $\mathbb{R}$ par $f(x) = 2x+1$, tend vers $+\infty$ quand $x$ tend vers $+\infty$.
Cependant, la fonction $-f : x \mapsto -2x - 1$ tend vers $-\infty$ quand $x$ tend vers $+\infty$.

<representation geogebra-id="afrnasga"></representation>

</bubble>

### Limite finie

<bubble variant="formula">

#### Limite finie en $+\infty$

Soit $f$ une fonction d'ensemble de définition $\mathcal{D}_f$. On suppose qu'une des bornes de $\mathcal{D}_f$ est
$+\infty$.

On dit que $f(x)$ **tend vers $\ell$** quand $x$ tend vers $+\infty$ si $f(x)$ est aussi proche de $\ell$ que l'on veut
pourvu que $x$ soit suffisamment grand.

</bubble>

De même, on peut écrire une définition semblable quand $x$ tend vers $-\infty$.

<bubble variant="tip">

#### Limite finie en $-\infty$

En reprenant les notations précédentes et en supposant qu'une des bornes de $\mathcal{D}_f$ soit $-\infty$, on dit que
$f(x)$ **tend vers $\ell$** quand $x$ tend vers $-\infty$ si $f(x)$ est aussi proche de $\ell$ que l'on veut pourvu que
$x$ soit suffisamment petit.

</bubble>

<bubble variant="tip">

#### Exemple

La fonction $f$ définie sur $\mathbb{R}^+$ par $f(x) = \frac{9x}{3x+1}$ tend vers $3$ quand $x$ tend vers $+\infty$.

<representation geogebra-id="rs8mkymv"></representation>

</bubble>

### Asymptote horizontale

<bubble variant="formula">

#### Définition en $+\infty$

Soit $f$ une fonction d'ensemble de définition $\mathcal{D}_f$. On suppose qu'une des bornes de $\mathcal{D}_f$ est
$+\infty$.

Alors si $f(x)$ admet une limite finie $\ell$ quand $x$ tend vers $+\infty$, alors la droite d'équation $y = \ell$ est
une **asymptote horizontale** en $+\infty$ à la courbe représentative de $f$.

</bubble>

Comme tout ce que l'on a vu avant, il existe une définition semblable en $-\infty$.

<bubble variant="tip">

#### Définition en $-\infty$

Soit $f$ une fonction d'ensemble de définition $\mathcal{D}_f$. On suppose qu'une des bornes de $\mathcal{D}_f$ est
$-\infty$.

Alors si $f(x)$ admet une limite finie $\ell$ quand $x$ tend vers $-\infty$, alors la droite d'équation $y = \ell$ est
une **asymptote horizontale** en $-\infty$ à la courbe représentative de $f$.

</bubble>

<bubble variant="tip">

#### Exemple

En reprenant l'exemple précédent, la courbe représentative de la fonction $x \mapsto \frac{9x}{3x+1}$ admet une
asymptote horizontale d'équation $y=3$ en $+\infty$.

De plus, elle admet une asymptote verticale d'équation $x=-\frac{1}{3}$.

</bubble>

## Calcul de limites

### Limites de fonctions de référence

Nous allons donner quelques fonctions classiques avec leur limite en quelques points.

<bubble variant="formula">

#### Limites de fonctions usuelles

|  | $a = -\infty$ | $a = 0$ | $a = +\infty$ |
| --- | --- | --- | --- |
| $\lim_{x \rightarrow a} \frac{1}{x}$ | $0$ | $-\infty$ si $a = 0^-$, $+\infty$ si $a = 0^+$ | $0$ |
| $\lim_{x \rightarrow a} \sqrt{x}$ | **Non définie** | $0$ si $a = 0^+$ | $+\infty$ |
| $\lim_{x \rightarrow a} x^k$ | $-\infty$ si $k$ est impair, $+\infty$ si $k$ est pair | $0$ | $+\infty$ |
| $\lim_{x \rightarrow a} e^x$ | $0$ | $e^0 = 1$ | $+\infty$ |

</bubble>

<bubble variant="tip">

#### Rappel

On rappelle que $0^-$ signifie tend vers $0$ mais en restant inférieur à $0$ et $0^+$ signifie tend vers $0$ mais en
restant supérieur à $0$.

</bubble>

### Opérations sur les limites

Dans tout ce qui suit, $f$ et $g$ sont deux fonctions de domaines de définition $\mathcal{D}_f$ et $\mathcal{D}_g$. Soit
$a$ un nombre réel appartenant à $\mathcal{D}_f \, \cap \, \mathcal{D}_g$ (ou qui est au moins une borne des deux à la
fois). Les tableaux suivants ressemblent beaucoup à ceux qui sont disponibles dans le cours
sur [les suites](/cours/terminale/suites/) donc vous pouvez bien-sûr n'en retenir qu'un des deux, et tenter à partir de
là de retrouver l'autre.

<bubble variant="formula">

#### Limite d'une somme

| Limite d'une somme                                                                                                                     |
| -------------------------------------------------------------------------------------------------------------------------------------- |
| Si la limite de $f(x)$ quand $x$ tend vers $a$ est...     | $\ell$         | $\ell$    | $\ell$    | $+\infty$ | $-\infty$ | $+\infty$ |
| Et la limite de $g$ quand $x$ tend vers $a$ est...        | $\ell'$        | $+\infty$ | $-\infty$ | $+\infty$ | $-\infty$ | $-\infty$ |
| Alors la limite de $f + g$ quand $x$ tend vers $a$ est... | $\ell + \ell'$ | $+\infty$ | $-\infty$ | $+\infty$ | $-\infty$ | **?**     |

</bubble>

<bubble variant="formula">

#### Limite d'un produit

| Limite d'un produit                                                                                                                                                                                 |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Si la limite de $f(x)$ quand $x$ tend vers $a$ est...          | $\ell$              | $\ell \gt 0$ | $\ell \gt 0$ | $\ell \lt 0$ | $\ell \lt 0$ | $+\infty$ | $+\infty$ | $-\infty$ | $0$          |
| Et la limite de $g$ quand $x$ tend vers $a$ est...             | $\ell'$             | $+\infty$    | $-\infty$    | $+\infty$    | $-\infty$    | $+\infty$ | $-\infty$ | $-\infty$ | $\pm \infty$ |
| Alors la limite de $f \times g$ quand $x$ tend vers $a$ est... | $\ell \times \ell'$ | $+\infty$    | $-\infty$    | $-\infty$    | $+\infty$    | $+\infty$ | $-\infty$ | $+\infty$ | **?**        |

</bubble>

<bubble variant="formula">

#### Limite d'un quotient

| Limite d'un quotient                                                                                                                                                                                                        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Si la limite de $f(x)$ quand $x$ tend vers $a$ est...           | $\ell$                              | $\ell$        | $+\infty$     | $+\infty$     | $-\infty$     | $-\infty$     | $\pm \infty$ | $\ell$       | $0$   |
| Et la limite de $g$ quand $x$ tend vers $a$ est...              | $\ell' \neq 0$                      | $\pm \infty$  | $\ell' \gt 0$ | $\ell' \lt 0$ | $\ell' \gt 0$ | $\ell' \lt 0$ | $\pm \infty$ | $0$          | $0$   |
| Alors la limite de $\frac{f}{g}$ quand $x$ tend vers $a$ est... | $\displaystyle{\frac{\ell}{\ell'}}$ | $0$           | $+\infty$     | $-\infty$     | $-\infty$     | $+\infty$     | **?**        | $\pm \infty$ | **?** |

</bubble>

<bubble variant="formula">

#### Limite d'une composée

Si on pose $\lim_{x \rightarrow a} f(x) = b$ et $\lim_{x \rightarrow b} g(x) = c$. Alors $\lim_{x \rightarrow} (g \circ
f)(x) = c$.

</bubble>

<bubble variant="tip">

#### Formes indéterminées

À noter qu'il n'existe que 4 formes indéterminées : $+\infty - \infty$, $0 \times \pm \infty$, $\frac{\pm \infty}{\pm
\infty}$ et $\frac{0}{0}$.

</bubble>

### Comparaisons et encadrements

<bubble variant="formula">

#### Théorèmes de comparaison

Soient deux fonctions $f$ et $g$.

* Si $\lim_{x \rightarrow +\infty} f(x) = +\infty$ et si $f \leq g$ à partir d'un certain point, alors $\lim_{x
  \rightarrow +\infty} g(x) = +\infty$.
* Si $\lim_{x \rightarrow +\infty} f(x) = -\infty$ et si $f \geq g$ à partir d'un certain point, alors $\lim_{x
  \rightarrow +\infty} g(x) = -\infty$.

</bubble>

<bubble variant="formula">

#### Théorème des gendarmes

Soient trois fonctions $f$, $g$ et $h$. Si on a $f \leq g \leq h$ à partir d'un certain point, et qu'il existe $\ell$
tel que $\lim_{x \rightarrow +\infty} f(x) = \ell$ et $\lim_{x \rightarrow +\infty} h(x) = \ell$, alors $\lim_{x
\rightarrow +\infty} g(x) = \ell$.

</bubble>

<bubble variant="tip">

#### Exemple

Utilisons ce théorème pour montrer que la fonction $f : x \mapsto \frac{\sin(x)}{x}$ tend vers $0$ quand $x$ tend vers
$+\infty$.

Tout d'abord, pour tout $x \in \mathbb{R}$, $-1 \leq \sin(x) \leq 1$.

Donc, pour tout $x \gt 0$, $\frac{-1}{x} \leq \underbrace{\frac{\sin(x)}{x}}_{= f(x)} \leq \frac{1}{x}$.

Comme, $\lim_{x \rightarrow +\infty} \frac{-1}{x} = 0$ et $\lim_{x \rightarrow +\infty} \frac{1}{x} = 0$, alors $\lim_{x
\rightarrow +\infty} f(x) = 0$.

</bubble>

Le dernier théorème est la <q>version fonctions</q> du théorèmes des gendarmes (que l'on a vu lors du cours
sur [les suites](/cours/terminale/suites/). Ils permettent notamment de démontrer une partie du **théorème des
croissances comparées**.

<bubble variant="formula">

#### Croissances comparées

$\lim_{x \rightarrow +\infty} \frac{e^x}{x^n} = +\infty$ pour tout $n \in \mathbb{N}$.

</bubble>

<bubble variant="proof">

#### Croissances comparées

Commençons tout d'abord par montrer que pour tout $x \geq 0$, $e^x \geq 1 + x$. Pour cela, posons $f : x \mapsto e^x - 1
- x$. On a pour tout $x \in \mathbb{R}$, $f'(x) = e^x - 1$. Donc $f'(x)$ est positif si et seulement si $e^x - 1 \geq
0$, c'est-à-dire $e^x \geq 1$.

En regardant le graphique de la fonction exponentielle, on trouve que cela est équivalent à $x \geq 0$.

Notre fonction est donc croissante sur l'intervalle $[0, +\infty[$, et son minimum est donc atteint en $x = 0$ et vaut
$f(0) = 0$. Ainsi, pour tout $x \geq 0$, $f(x) \geq 0 \iff e^x - 1 - x \geq 0 \iff e^x \geq 1 + x$ : ce que l'on
cherchait.

Pour conclure, on utilise une petite astuce. Soit $n \in \mathbb{N}$ :

D'après ce que l'on vient de faire, pour tout $x \gt 0$, $e^{\frac{x}{n+1}} \geq 1 + \frac{x}{n+1} \gt \frac{x}{n+1}$.
Ainsi, en mettant à la puissance $n + 1$ (qui ne change pas le sens de l'inégalité car les deux membres sont positifs),
on a :

$e^x \gt (\frac{x}{n+1})^{n+1} = \frac{x^{n+1}}{(n+1)^{n+1}}$

Maintenant, on divise les deux côtés par $x^n$ (qui est un nombre strictement positif) et on obtient :

$\frac{e^x}{x^n} \gt \frac{x}{(n+1)^{n+1}}$

Or, le membre de droite tend vers $+\infty$ quand $x$ tend vers $+\infty$ donc le membre de gauche aussi d'après les
théorèmes de comparaison.

</bubble>
