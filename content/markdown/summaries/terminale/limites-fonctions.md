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

Il est tout à fait possible d'établir une définition similaire pour une fonction tendant vers $-\infty$ en un point.

### Limite finie

<bubble variant="formula">

#### Définition

Soit $f$ une fonction d'ensemble de définition $\mathcal{D}_f$. Soit $a$ un réel appartenant à $\mathcal{D}_f$ ou étant
une borne de $\mathcal{D}_f$.

On dit que $f(x)$ **tend vers $\ell$** quand $x$ tend vers $a$ si $f(x)$ est aussi proche de $\ell$ que l'on veut pourvu
que $x$ soit suffisamment proche de $a$.

On note ceci $\lim_{x \rightarrow a} f(x) = \ell$.

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

### Asymptote verticale

<bubble variant="formula">

#### Définition

Soit $f$ une fonction d'ensemble de définition $\mathcal{D}_f$. Soit $a$ un réel appartenant à $\mathcal{D}_f$ ou étant
une borne de $\mathcal{D}_f$.

Alors si $f(x)$ admet une limite infinie quand $x$ tend vers $a$, alors la droite d'équation $x = a$ est une **asymptote
verticale** à la courbe représentative de $f$.

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

### Limite finie

<bubble variant="formula">

#### Limite finie en $+\infty$

Soit $f$ une fonction d'ensemble de définition $\mathcal{D}_f$. On suppose qu'une des bornes de $\mathcal{D}_f$ est
$+\infty$.

On dit que $f(x)$ **tend vers $\ell$** quand $x$ tend vers $+\infty$ si $f(x)$ est aussi proche de $\ell$ que l'on veut
pourvu que $x$ soit suffisamment grand.

</bubble>

De même, on peut écrire une définition semblable quand $x$ tend vers $-\infty$.

### Asymptote horizontale

<bubble variant="formula">

#### Définition en $+\infty$

Soit $f$ une fonction d'ensemble de définition $\mathcal{D}_f$. On suppose qu'une des bornes de $\mathcal{D}_f$ est
$+\infty$.

Alors si $f(x)$ admet une limite finie $\ell$ quand $x$ tend vers $+\infty$, alors la droite d'équation $y = \ell$ est
une **asymptote horizontale** en $+\infty$ à la courbe représentative de $f$.

</bubble>

Comme tout ce que l'on a vu avant, il existe une définition semblable en $-\infty$.

## Calcul de limites

### Limites de fonctions de référence

Nous allons donner quelques fonctions classiques avec leur limite en quelques points.

<bubble variant="formula">

#### Limites de fonctions usuelles

|                                      | $a = -\infty$                                          | $a = 0$                                        | $a = +\infty$ |
| ------------------------------------ | ------------------------------------------------------ | ---------------------------------------------- | ------------- |
| $\lim_{x \rightarrow a} \frac{1}{x}$ | $0$                                                    | $-\infty$ si $a = 0^-$, $+\infty$ si $a = 0^+$ | $0$           |
| $\lim_{x \rightarrow a} \sqrt{x}$    | **Non définie**                                        | $0$ si $a = 0^+$                               | $+\infty$     |
| $\lim_{x \rightarrow a} x^k$         | $-\infty$ si $k$ est impair, $+\infty$ si $k$ est pair | $0$                                            | $+\infty$     |
| $\lim_{x \rightarrow a} e^x$         | $0$                                                    | $e^0 = 1$                                      | $+\infty$     |

</bubble>

### Opérations sur les limites

Dans tout ce qui suit, $f$ et $g$ sont deux fonctions de domaines de définition $\mathcal{D}_f$ et $\mathcal{D}_g$. Soit
$a$ un nombre réel appartenant à $\mathcal{D}_f \, \cap \, \mathcal{D}_g$ (ou qui est au moins une borne des deux à la
fois). Les tableaux suivants ressemblent beaucoup à ceux qui sont disponibles dans le cours
sur [les suites](/cours/terminale/suites/) donc vous pouvez bien-sûr n'en retenir qu'un des deux, et tenter à partir de
là de retrouver l'autre.

<bubble variant="formula">

#### Limite d'une somme

| Limite d'une somme                                        |                |           |           |           |           |           |
| ----------------------------------------------------------|----------------|-----------|-----------|-----------|-----------|---------- |
| Si la limite de $f(x)$ quand $x$ tend vers $a$ est...     | $\ell$         | $\ell$    | $\ell$    | $+\infty$ | $-\infty$ | $+\infty$ |
| Et la limite de $g$ quand $x$ tend vers $a$ est...        | $\ell'$        | $+\infty$ | $-\infty$ | $+\infty$ | $-\infty$ | $-\infty$ |
| Alors la limite de $f + g$ quand $x$ tend vers $a$ est... | $\ell + \ell'$ | $+\infty$ | $-\infty$ | $+\infty$ | $-\infty$ | **?**     |

</bubble>

<bubble variant="formula">

#### Limite d'un produit

| Limite d'un produit                                            |                     |              |              |              |              |           |           |           |              |
| ---------------------------------------------------------------|---------------------|--------------|--------------|--------------|--------------|-----------|-----------|-----------|------------- |
| Si la limite de $f(x)$ quand $x$ tend vers $a$ est...          | $\ell$              | $\ell \gt 0$ | $\ell \gt 0$ | $\ell \lt 0$ | $\ell \lt 0$ | $+\infty$ | $+\infty$ | $-\infty$ | $0$          |
| Et la limite de $g$ quand $x$ tend vers $a$ est...             | $\ell'$             | $+\infty$    | $-\infty$    | $+\infty$    | $-\infty$    | $+\infty$ | $-\infty$ | $-\infty$ | $\pm \infty$ |
| Alors la limite de $f \times g$ quand $x$ tend vers $a$ est... | $\ell \times \ell'$ | $+\infty$    | $-\infty$    | $-\infty$    | $+\infty$    | $+\infty$ | $-\infty$ | $+\infty$ | **?**        |

</bubble>

<bubble variant="formula">

#### Limite d'un quotient

| Limite d'un quotient                                            |                                     |               |               |               |               |               |              |              |       |
| ----------------------------------------------------------------|-------------------------------------|---------------|---------------|---------------|---------------|---------------|--------------|--------------|------ |
| Si la limite de $f(x)$ quand $x$ tend vers $a$ est...           | $\ell$                              | $\ell$        | $+\infty$     | $+\infty$     | $-\infty$     | $-\infty$     | $\pm \infty$ | $\ell$       | $0$   |
| Et la limite de $g$ quand $x$ tend vers $a$ est...              | $\ell' \neq 0$                      | $\pm \infty$  | $\ell' \gt 0$ | $\ell' \lt 0$ | $\ell' \gt 0$ | $\ell' \lt 0$ | $\pm \infty$ | $0$          | $0$   |
| Alors la limite de $\frac{f}{g}$ quand $x$ tend vers $a$ est... | $\displaystyle{\frac{\ell}{\ell'}}$ | $0$           | $+\infty$     | $-\infty$     | $-\infty$     | $+\infty$     | **?**        | $\pm \infty$ | **?** |

</bubble>

<bubble variant="formula">

#### Limite d'une composée

Si on pose $\lim_{x \rightarrow a} f(x) = b$ et $\lim_{x \rightarrow b} g(x) = c$. Alors $\lim_{x \rightarrow} (g \circ
f)(x) = c$.

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

Le dernier théorème est la <q>version fonctions</q> du théorèmes des gendarmes (que l'on a vu lors du cours
sur [les suites](/cours/terminale/suites/)). Ils permettent notamment de démontrer une partie du **théorème des
croissances comparées**.

<bubble variant="formula">

#### Croissances comparées

$\lim_{x \rightarrow +\infty} \frac{e^x}{x^n} = +\infty$ pour tout $n \in \mathbb{N}$.

</bubble>
