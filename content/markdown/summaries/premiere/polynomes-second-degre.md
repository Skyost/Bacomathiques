## Qu'est-ce qu'une fonction polynômiale du second degré ?

### Définition

<bubble variant="formula">

#### Définition

Soit $f$ une fonction. $f$ est une **fonction polynômiale du second degré** si elle est de la forme $f : x \mapsto ax^2
+ bx + c$ avec $a \neq 0$, $b$ et $c$ réels qui sont les **coefficients** de $f$.

</bubble>

En classe de Première, ces fonctions auront pour ensemble de départ et d'arrivée $\mathbb{R}$ mais il faut savoir qu'il
est possible d'en prendre d'autres.

### Représentation graphique

<bubble variant="formula">

#### Parabole

Soit $f$ une fonction polynômiale du second degré. Alors la courbe représentative de $f$ (notée $\mathcal{C}_f$) est
une **parabole**.

</bubble>

<representation geogebra-id="drmymnkb"></representation>

Chaque coefficient d'une fonction du second degré a un rôle dans le tracé de sa parabole.

<bubble variant="formula">

#### Rôle des coefficients dans la représentation graphique

Soit $f$ de la forme $f(x) = ax^2 + bx +c$ (avec $a \neq 0$, $b$ et $c$ réels). Alors on a que :

* $a$ et $b$ contrôlent **l'allure générale** de la courbe (son orientation, son inclinaison, ...).
* $c$ contrôle l'éloignement de la courbe par rapport à **l'axe des abscisses**.

</bubble>

## Recherche de racines

### Qu'est-ce qu'une racine ?

<bubble variant="formula">

#### Définition

Soient $f$ une fonction polynômiale du second degré et $x_0 \in \mathbb{R}$. On dit que $x_0$ est **une racine** de $f$
si $f(x_0) = 0$.

</bubble>

### Discriminant

<bubble variant="formula">

#### Définition

Soit $f$ une fonction polynômiale du second degré de la forme $f(x) = ax^2 + bx + c$ (avec $a \neq 0$, $b$ et $c$ réels)
. On appelle **discriminant** de $f$ le réel suivant : $\Delta = b^2 - 4ac$.

</bubble>

<bubble variant="formula">

#### Propriétés

Plusieurs propriétés découlent du signe de $\Delta$ :

* Si $\Delta \lt 0$ alors $f$ n'admet pas de racine réelle.
* Si $\Delta = 0$ alors $f$ admet une unique racine réelle : $x_0 = \displaystyle{\frac{-b}{2a}}$.
* Si $\Delta \gt 0$ alors $f$ admet deux racines réelles : $x_1 = \displaystyle{\frac{-b - \sqrt{\Delta}}{2a}}$ et $x_2
  = \displaystyle{\frac{-b + \sqrt{\Delta}}{2a}}$.

</bubble>

### Racines évidentes

<bubble variant="formula">

#### Recherche des racines rationnelles

Soit $f$ une fonction polynômiale du second degré de la forme $f(x) = ax^2 + bx +c$ (avec $a \neq 0$, $b$ et $c$ réels).
On note $D_c$ l'ensemble des diviseurs de $c$ et $D_a$ l'ensemble des diviseurs de $a$. Alors :

Pour trouver une éventuelle racine rationnelle de $f$, on calcule $\displaystyle{f\left(\frac{p}{q}\right)}$ pour tout
$p \in D_c$ et $q \in D_a$, jusqu'à tomber sur $0$.

</bubble>

### Somme et produit de racines

<bubble variant="formula">

#### Relations

Soit $f$ une fonction polynômiale du second degré de la forme $f(x) = ax^2 + bx +c$ (avec $a \neq 0$, $b$ et $c$ réels)
admettant deux racines réelles $x_1$ et $x_2$. Alors :

* La somme $S = x_1 + x_2$ des racines vaut également $\displaystyle{-\frac{b}{a}}$.
* Le produit $P = x_1 \times x_2$ des racines vaut également $\displaystyle{\frac{c}{a}}$.

</bubble>

### Forme factorisée

<bubble variant="formula">

#### Définition

Soit $f$ une fonction polynômiale du second degré de la forme $f(x) = ax^2 + bx +c$ (avec $a \neq 0$, $b$ et $c$ réels)
admettant deux racines réelles $x_1$ et $x_2$. Alors :

$f$ admet une **forme factorisée** qui vaut $f(x) = a(x-x_1)(x-x_2)$ pour tout $x \in \mathbb{R}$.

</bubble>

Une propriété découle immédiatement de cette méthode :

<bubble variant="formula">

Si $c = 0$, alors $\displaystyle{-\frac{b}{a}}$ et $0$ sont racines.

</bubble>

## Étude des fonctions polynômiales du second degré

### Signe

<bubble variant="formula">

#### Signe d'une fonction du second degré

Soit $f$ une fonction polynômiale du second degré de la forme $f(x) = ax^2 + bx +c$ (avec $a \neq 0$, $b$ et $c$ réels)
admettant deux racines réelles $x_1$ et $x_2$. On suppose ici que $x_1 \lt x_2$, alors :

* Si $a \lt 0$ : $f(x) \lt 0$ sur $]-\infty; x_1[ \, \cup \, ]x_2; +\infty[$ et $f(x) \gt 0$ sur $]x_1; x_2[$.
* Si $a \gt 0$ : $f(x) \gt 0$ sur $]-\infty; x_1[ \, \cup \, ]x_2; +\infty[$ et $f(x) \lt 0$ sur $]x_1; x_2[$.

</bubble>

### Variations

<bubble variant="formula">

#### Forme canonique

Soit $f$ une fonction polynômiale du second degré de la forme $f(x) = ax^2 + bx +c$ (avec $a \neq 0$, $b$ et $c$ réels),
alors pour tout $x \in \mathbb{R}$, on peut écrire $f$ de la forme :

$f(x) = a(x - \alpha)^2 + \beta$ avec $\displaystyle{\alpha = -\frac{b}{2a}}$ et $\beta = f(\alpha)$.

</bubble>

Cette forme est appelée **forme canonique** de $f$ et elle possède de nombreuses propriétés intéressantes.

<bubble variant="formula">

#### Sommet de la parabole

Soit $S$ le sommet de la parabole $\mathcal{C}_f$. Alors les coordonnées de $S$ sont $(\alpha, \beta)$.

Si $a \lt 0$, ce sommet est un maximum et si $a \gt 0$, ce sommet est un minimum.

</bubble>

Avec les remarques données précédemment, on peut en déduire les variations de la fonction $f$.

<bubble variant="formula">

#### Sens de variation

* Si $a \lt 0$ : $f$ est strictement croissante sur $]-\infty; \alpha]$ et est strictement décroissante sur $]\alpha;
  +\infty]$.
* Si $a \gt 0$ : $f$ est strictement décroissante sur $]-\infty; \alpha]$ et est strictement croissante sur $]\alpha;
  +\infty]$.

</bubble>

### Axe de symétrie

<bubble variant="formula">

#### Axe de symétrie

Soit $f$ une fonction polynômiale du second degré de la forme $f(x) = ax^2 + bx +c$ (avec $a \neq 0$, $b$ et $c$ réels).
On note $\mathcal{C}_f$ sa courbe représentative. Alors :

$\mathcal{C}_f$ possède un axe de symétrie : la droite $\mathcal{D}$ d'équation $\displaystyle{x = -\frac{b}{2a}}$.

</bubble>
