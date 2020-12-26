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

<bubble variant="tip">

#### Parité d'une fonction

On voit sur la représentation ci-dessus que la courbe est symétrique par rapport à l'axe des ordonnées : la fonction $f$
représentée est **paire** (i.e. pour tout $x \in D_f$, $f(-x) = f(x)$).

Inversement si une fonction $f$ est symétrique par rapport à l'axe des abscisses, elle est dite **impaire** (i.e. pour
tout $x \in D_f$, $-f(x) = f(x)$).

</bubble>

Chaque coefficient d'une fonction du second degré a un rôle dans le tracé de sa parabole.

<bubble variant="formula">

#### Rôle des coefficients dans la représentation graphique

Soit $f$ de la forme $f(x) = ax^2 + bx +c$ (avec $a \neq 0$, $b$ et $c$ réels). Alors on a que :

* $a$ et $b$ contrôlent **l'allure générale** de la courbe (son orientation, son inclinaison, ...).
* $c$ contrôle l'éloignement de la courbe par rapport à **l'axe des abscisses**.

</bubble>

<bubble variant="tip">

Rien que le signe de $a$ peut changer toute l'allure de la courbe :

* Si $a \lt 0$, la fonction est décroissante puis croissante.
* Si $a \gt 0$, la fonction est croissante puis décroissante.

</bubble>

## Recherche de racines

### Qu'est-ce qu'une racine ?

<bubble variant="formula">

#### Définition

Soient $f$ une fonction polynômiale du second degré et $x_0 \in \mathbb{R}$. On dit que $x_0$ est **une racine** de $f$
si $f(x_0) = 0$.

</bubble>

<bubble variant="tip">

Autrement dit, résoudre l'équation $f(x) = 0$ revient à rechercher les racines de $f$. Pour cela il existe beaucoup de
méthodes et nous en détaillerons certaines par la suite.

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

<bubble variant="tip">

#### Exemple

Résolvons l'équation $x^2 = 4$ pour $x \in \mathbb{R}$.

On a $x^2 = 4 \iff x^2 - 4 = 0$. Il s'agit en fait de chercher les racines de la fonction du second degré définie pour
tout $x \in \mathbb{R}$ par $f(x) = x^2 - 4$.

On identifie les coefficients : $a = 1$, $b = 0$ et $c = -4$ ; puis on calcule le discriminant $\Delta = b^2 - 4ac = 0 -
4 \times 1 \times -4 = 16$.

Comme $\Delta \gt 0$, on a deux racines réelles :

$\displaystyle{x_1 = \frac{-b - \sqrt{\Delta}}{2a} = -2}$ et $\displaystyle{x_2 = \frac{-b + \sqrt{\Delta}}{2a} = 2}$.

Donc l'ensemble des solutions est $S = \{-2; 2\}$.

</bubble>

### Racines évidentes

<bubble variant="formula">

#### Recherche des racines rationnelles

Soit $f$ une fonction polynômiale du second degré de la forme $f(x) = ax^2 + bx +c$ (avec $a \neq 0$, $b$ et $c$ réels).
On note $D_c$ l'ensemble des diviseurs de $c$ et $D_a$ l'ensemble des diviseurs de $a$. Alors :

Pour trouver une éventuelle racine rationnelle de $f$, on calcule $\displaystyle{f\left(\frac{p}{q}\right)}$ pour tout
$p \in D_c$ et $q \in D_a$, jusqu'à tomber sur $0$.

</bubble>

<bubble variant="tip">

#### Exemple

Utilisons cette méthode pour déterminer les éventuelles racines rationnelles de la fonction $f$ définie sur $\mathbb{R}$
par $f(x) = 4x^2 - 1$.

On a ici $a = 4$, $b = 0$ et $c = -1$ ; la liste des diviseurs de $c$ est : $-1$ et $1$.

La liste des diviseurs de $a$ est : $4$, $2$, $1$, $-1$, $-2$ et $-4$.

Il ne reste qu'à tester :

$\displaystyle{f\left(\frac{-1}{4}\right)=f\left(\frac{1}{-4}\right) \neq 0}$

$\displaystyle{f\left(\frac{-1}{2}\right)=f\left(\frac{1}{-2}\right)=0}$ **Une racine !**

$\displaystyle{f\left(\frac{-1}{1}\right)=f(-1) \neq 0}$

$\displaystyle{f\left(\frac{-1}{-1}\right)=f(1) \neq 0}$

$\displaystyle{f\left(\frac{-1}{-2}\right)=f\left(\frac{1}{2}\right)=0}$ **Une racine !**

On a deux racines rationnelles : $\displaystyle{-\frac{1}{2}}$ et $\displaystyle{\frac{1}{2}}$.

Pas besoin d'aller plus loin car on a trouvé deux racines et un polynôme du second degré n'admet que deux racines
maximum.

Signalons de plus que l'on aurait pu s'arrêter après avoir trouvé la première racine car $f$ est une fonction paire.

</bubble>

### Somme et produit de racines

<bubble variant="formula">

#### Relations

Soit $f$ une fonction polynômiale du second degré de la forme $f(x) = ax^2 + bx +c$ (avec $a \neq 0$, $b$ et $c$ réels)
admettant deux racines réelles $x_1$ et $x_2$. Alors :

* La somme $S = x_1 + x_2$ des racines vaut également $\displaystyle{-\frac{b}{a}}$.
* Le produit $P = x_1 \times x_2$ des racines vaut également $\displaystyle{\frac{c}{a}}$.

</bubble>

<bubble variant="tip">

#### Exemple

Il peut être très utile de combiner cette méthode avec celle des racines évidentes !

Par exemple, cherchons les solutions de l'équation $x^2 + 2x + 1 = 0$.

Il faut donc chercher les racines de la fonction de degré 2 définie pour tout $x \in \mathbb{R}$ par $f(x) = x^2 + 2x +
1$.

On a $a = 1$, $b = 2$ et $c = 1$. Avec la méthode des racines évidentes, on trouve une racine $x_1 = -1$.

Or, on a $\displaystyle{x_1 \times x_2 = \frac{c}{a} \iff x_2 = -1}$. La deuxième racine vaut aussi $-1$.

On dit que $-1$ est **racine double**.

</bubble>

### Forme factorisée

<bubble variant="formula">

#### Définition

Soit $f$ une fonction polynômiale du second degré de la forme $f(x) = ax^2 + bx +c$ (avec $a \neq 0$, $b$ et $c$ réels)
admettant deux racines réelles $x_1$ et $x_2$. Alors :

$f$ admet une **forme factorisée** qui vaut $f(x) = a(x-x_1)(x-x_2)$ pour tout $x \in \mathbb{R}$.

</bubble>

<bubble variant="tip">

#### Exemple

Chercher les racines de la fonction définie pour tout $x \in \mathbb{R}$ par $f(x) = x^2 - 6x + 9$.

Avec une identité remarquable, on factorise $f$ : $f(x) = (x - 3)^2$.

Cela correspond à la forme factorisée de $f$ et elle nous permet d'en déduire que $3$ est une racine double de $f$.

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

<bubble variant="tip">

Si $x_1 = x_2$ ou si $f$ n'admet pas de racine, alors $f$ est du signe de $a$.

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

<bubble variant="tip">

Cela veut tout simplement dire que :

* Si $a \lt 0$, le maximum de $f$ est atteint en $\alpha$ et vaut $\beta$ (donc pour tout $x \in \mathbb{R}$, $f(x) \leq
  \beta$).
* Si $a \gt 0$, le minimum de $f$ est atteint en $\alpha$ et vaut $\beta$ (donc pour tout $x \in \mathbb{R}$, $f(x) \geq
  \beta$).

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

<bubble variant="tip">

En fait, $\mathcal{D}$ est juste la droite verticale passant par le [sommet](#variations) de la parabole.

</bubble>
