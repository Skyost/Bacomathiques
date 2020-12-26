## L'ensemble des nombres complexes $\mathbb{C}$

### Qu'est-ce que l'ensemble $\mathbb{C}$ ?

<bubble variant="formula">

#### L'ensemble $\mathbb{C}$

Il existe un ensemble de nombres noté $\mathbb{C}$ qui contient l'ensemble $\mathbb{R}$ ainsi qu'un nombre $i \in
\mathbb{C}$ vérifiant $i^2 = -1$.

</bubble>

Cet ensemble est appelé **ensemble des nombres complexes** et obéit aux mêmes règles de calcul que l'ensemble
$\mathbb{R}$.

### Forme algébrique d'un nombre complexe

<bubble variant="formula">

#### Forme algébrique

Tout **nombre complexe** $z$ peut s'écrire $z = x+iy$ où $x$ et $y$ sont deux réels. Cette écriture est appelée **forme
algébrique** de $z$. On dit que :

* $x$ est la **partie réelle** de $z$ (notée $\operatorname{Re}(z)$).
* $y$ est la **partie imaginaire** de $z$ (notée $\operatorname{Im}(z)$).

</bubble>

### Égalité entre nombres complexes

<bubble variant="formula">

#### Lien entre égalité et parties réelle et imaginaire

Deux nombres complexes $z$ et $z'$ sont **égaux** si et seulement si $\operatorname{Re}(z) = \operatorname{Re}(z')$ et
$\operatorname{Im}(z) = \operatorname{Im}(z')$.

</bubble>

Ainsi, pour que deux nombres complexes soient égaux, leur partie réelle et leur partie imaginaire doivent toutes deux
être égales.

### Conjugué

<bubble variant="formula">

#### Définition

Tout nombre complexe $z = x+iy$ admet un nombre complexe **conjugué** noté $\bar{z}$. Ce conjugué est le nombre complexe
$\bar{z} = x-iy$.

</bubble>

On donne également quelques formules permettant de calculer plus facilement des conjugués de nombres complexes.

<bubble variant="formula">

#### Relations

Soient $z$ et $z'$ deux nombres complexes.

* $\overline{z + z'} = \bar{z} + \bar{z'}$
* $\displaystyle{\overline{\left(\frac{z}{z'}\right)} = \frac{\bar{z}}{\bar{z'}}}$ où $z' \neq 0$
* $\overline{z^n} = (\bar{z})^n$ où $n \in \mathbb{N}$
* $\overline{z \times z'} = \bar{z} \times \bar{z'}$

</bubble>

Enfin, on a plusieurs propriétés intéressantes que l'on peut dégager.

<bubble variant="formula">

#### Propriétés

Soit $z$ un nombre complexe.

* $\bar{\bar{z}} = z$
* $z + \bar{z} = 2 \operatorname{Re}(z)$
* $z - \bar{z} = 2i \operatorname{Im}(z)$
* $z$ est un réel si et seulement si $z = \bar{z}$
* $z$ est un imaginaire pur si et seulement si $z = -\bar{z}$

</bubble>

### Module

<bubble variant="formula">

#### Définition

On appelle **module** d'un nombre complexe $z = x + iy$ (noté $|z|$) le réel $|z| = \sqrt{x^2 + y^2}$.

</bubble>

Le module possède des propriétés intéressantes (à la manière de la valeur absolue pour les réels).

<bubble variant="formula">

#### Formules

Soient $z$ et $z'$ deux nombres complexes.

* $|z| \geq 0$
* $|z| = 0 \iff z = 0$
* $|\alpha z| = \sqrt{\alpha^2} |z|$ pour tout $\alpha \in \mathbb{R}$ (en particulier, $|-z| = |z|$)
* $z\bar{z} = |z|^2$
* $|z| = |\bar{z}|$
* $|zz'| = |z| \times |z'|$
* $\displaystyle{\left|\frac{z}{z'}\right| = \frac{|z|}{|z'|}}$ où $z' \neq 0$
* $|z^n| = |z|^n$ où $n \in \mathbb{N}$

</bubble>

## Polynômes dans $\mathbb{C}$

### Qu'est-ce qu'un polynôme ?

<bubble variant="formula">

#### Définition

Soit $n$ un entier. On dit que $P$ est un **polynôme de degré $n$** si $P$ est une expression formelle de la forme : $P(
z) = a_0 + a_1 z + a_2 z^2 + \dots + a_n z^n$.

</bubble>

En classe de Terminale, on peut remplacer expression formelle par fonction (un polynôme de degré $n$ sera donc la même
chose qu'une **fonction polynômiale de degré $n$**). Dans ce chapitre, ce seront des fonctions à valeurs complexes.

<bubble variant="formula">

#### Racine d'un polynôme

On dit qu'un nombre complexe $a$ est une racine d'un polynôme $P$ si on a $P(a) = 0$.

</bubble>

On donne enfin la **formule du binôme de Newton**, qui peut s'avérer utile pour développer certaines expressions.

<bubble variant="formula">

#### Formule du binôme de Newton

Soient $a$ et $b$ deux nombres complexes.

Alors pour tout $n \in \mathbb{N}$, $\displaystyle{(a + b)^n = \sum_{k = 0}^n \binom{k}{n} a^k b^{n-k}}$.

</bubble>

On admet de plus une propriété fondamentale de $\mathbb{C}$.

<bubble variant="formula">

#### Théorème fondamental de l'algèbre

Tout polynôme non-nul de degré $n$ admet au plus $n$ racines complexes.

</bubble>

### Résolution d'une équation du second degré

Il est possible d'étendre la résolution d'une équation du second degré du type $ax^2 + bx + c = 0$ dans le cas ou le
polynôme admet un discriminant est négatif. Nous allons voir ici une méthode de résolution.

<bubble variant="formula">

#### Résolution d'une équation du second degré

On considère l'équation $(E) : az^2 + bz + c = 0$ (où $a$, $b$ et $c$ sont trois réels et $a \neq 0$). On pose $\Delta =
b^2 - 4ac$, et on a que les solutions de $(E)$ dépendent du signe de $\Delta$ :

* Si $\Delta \gt 0$, $(E)$ admet deux solutions réelles $\displaystyle{z_1 = \frac{-b - \sqrt{\Delta}}{2a}}$ et
  $\displaystyle{z_2 = \frac{-b + \sqrt{\Delta}}{2a}}$.
* Si $\Delta = 0$, $(E)$ admet une solution réelle $\displaystyle{z_0 = \frac{-b}{2a}}$.
* Si $\Delta \lt 0$, $(E)$ admet deux solutions complexes conjuguées $\displaystyle{z_1 = \frac{-b -
  i\sqrt{\Delta}}{2a}}$ et $\displaystyle{z_2 = \frac{-b + i\sqrt{\Delta}}{2a} = \bar{z_1}}$.

</bubble>

### Factorisation par $z-a$

<bubble variant="formula">

#### Factorisation par une racine

Soit $P$ un polynôme de degré $n$ et soit $a$ une racine de ce polynôme. Alors il existe un polynôme $Q$ de degré $n-1$
tel que pour tout $z \in \mathbb{C}$, $P(z) = (z-a)Q(z)$.

</bubble>

Une application possible de cette propriété est que tout polynôme $P$ de la forme $P(z) = z^n - a^n$ se factorise en $P(
z) = (z-a)Q(z)$ (où $Q$ est un polynôme de degré $n-1$) car $a$ est une racine de $P$ et que $P$ est un polynôme de
degré $n$.

## Géométrie avec les nombres complexes

### Formes trigonométrique et exponentielle

Tout nombre complexe peut s'écrire sous trois formes la **forme algébrique**, la **forme trigonométrique** et la **forme
exponentielle**.

<bubble variant="formula">

#### Forme trigonométrie

Pour obtenir la forme trigonométrique d'un nombre complexe $z = x + iy$, il faut tout d'abord obtenir
son [module](#module). La **forme trigonométrique** de $z$ est ensuite donnée par : $z = |z| (\cos(\theta) + i\sin(
\theta))$.

Avec $\theta$ **l'argument** de $z$ (noté $\operatorname{arg}(z)$) qui doit vérifier :

* $\displaystyle{\cos(\theta) = \frac{x}{|z|}}$
* $\displaystyle{\sin(\theta) = \frac{y}{|z|}}$

</bubble>

Une fois la forme trigonométrique obtenue, on peut passer à la forme exponentielle.

<bubble variant="formula">

#### Forme exponentielle / Formule d'Euler

Soit $z$ un nombre complexe écrit sous forme trigonométrique $z = |z| (\cos(\theta) + i\sin(\theta))$. Alors $z = |z|
e^{i\theta}$.

</bubble>

On peut étendre l'égalité entre nombres complexes donnée [au début](#égalité-entre-nombres-complexes) : deux nombres
complexes sont égaux s'ils ont le **même module** et le **même argument (modulo $2\pi$, nous détaillerons ce point-ci
plus tard)**.

### Propriétés de l'argument

<bubble variant="formula">

#### Propriétés

Soit $z$ un nombre complexe.

* $z$ est un réel si et seulement si $\operatorname{arg}(z) = k \times \pi$ où $k \in \mathbb{Z}$
* $z$ est un imaginaire pur si et seulement si $\operatorname{arg}(z) = k \times \frac{\pi}{2}$ où $k \in \mathbb{Z}$

</bubble>

Pour conclure cette partie, nous allons donner quelques formules permettant de calculer des arguments.

<bubble variant="formula">

#### Formules

Soient $z$ et $z'$ deux nombres complexes.

* $\operatorname{arg}(\bar{z}) = - \operatorname{arg}(z) \mod 2\pi$
* $\operatorname{arg}(- z) = - \operatorname{arg}(z) + \pi \mod 2\pi$
* $\operatorname{arg}(z \times z') = \operatorname{arg}(z) + \operatorname{arg}(z') \mod 2\pi$
* $\displaystyle{\operatorname{arg}\left(\frac{1}{z}\right) = - \operatorname{arg}(z) \mod 2\pi}$
* $\displaystyle{\operatorname{arg}\left(\frac{z}{z'}\right) = \operatorname{arg}(z) - \operatorname{arg}(z') \mod
  2\pi}$
* $\operatorname{arg}(z^n) = n \times \operatorname{arg}(z) \mod 2\pi$ pour tout $n \in \mathbb{N}$

</bubble>

### Affixe et représentation

Dans tout ce qui suit, le plan sera muni d'un repère $(O; \overrightarrow{i}; \overrightarrow{j})$.

<bubble variant="formula">

#### Affixe d'un point

Un nombre complexe $z = x+iy$ peut être représenté dans le plan par un point $M$ de coordonnées $(x; y)$. $z$ est alors
appelé **affixe** du point $M$ (et réciproquement le point $M$ est **l'image** de $z$).

Un nombre complexe $z' = |z'| e^{\theta}$ peut être représenté dans le plan par un point $M'$ situé sur le cercle
d'origine $O$ et de rayon

$|z'|$. Le point $M'$ est alors situé à l'angle de $\theta$ radians sur ce cercle. Le module est donc une **distance**
et l'argument est un **angle**.

</bubble>

### Lien Géométrie - Nombres complexes

Une propriété remarquable des nombres complexes est qu'il est possible de les utiliser pour faire de la géométrie ! Cela
peut sembler surprenant, mais cela repose sur le fait que tout nombre complexe $z$ s'écrit $x + iy$ (avec $x$ la partie
réelle de $z$ et $y$ sa partie imaginaire), et que, comme dit dans la partie précédente, on peut y associer le point de
coordonnées $(x; y)$.

Voici, de manière plus formelle, quelques propriétés de géométrie reposant sur l'utilisation des nombres complexes. On
rappelle que l'on se place dans un repère $(O; \overrightarrow{i}; \overrightarrow{j})$.

<bubble variant="formula">

#### Affixe d'un vecteur

Soient $A$ et $B$ deux points d'affixes respectives $z_A$ et $z_B$. Alors on associe au vecteur $\overrightarrow{AB}$
son **affixe** qui est le complexe $z_B - z_A$.

</bubble>

<bubble variant="formula">

#### Propriétés

Soient $A$, $B$, $C$ et $D$ des points d'affixes respectives $z_A$, $z_B$, $z_C$ et $z_D$.

* **La longueur $AB$ est :** le module du complexe $z_B - z_A$ (i.e. $|z_B - z_A|$). Il s'agit également de la norme du
  vecteur $\overrightarrow{AB}$.
* **Le milieu du segment $[AB]$ est :** le point $M$ d'affixe $\displaystyle{z_{M} = \frac{z_A + z_B}{2}}$.
* **L'angle $(\overrightarrow{i}; \overrightarrow{AB})$ est :** l'argument du complexe $z_B - z_A$ (i.e.
  $\operatorname{arg}(z_B - z_A)$, modulo $2\pi$).
* **L'angle $(\overrightarrow{AB}; \overrightarrow{CD})$ est :** l'argument du complexe $\displaystyle{\left(\frac{z_C -
  z_D}{z_B - z_A}\right)}$ (i.e. $\displaystyle{\operatorname{arg}\left(\frac{z_C - z_D}{z_B - z_A}\right)}$, modulo
  $2\pi$).

</bubble>

### L'ensemble $\mathbb{U}$ et les racines $n$-ièmes de l'unité

<bubble variant="formula">

#### L'ensemble $\mathbb{U}$

On note par $\mathbb{U}$ l'ensemble des nombres complexes de module $1$.

</bubble>

<bubble variant="formula">

#### Stabilité de $\mathbb{U}$

Soient $z$, $z' \in \mathbb{U}$. Alors $z \times z' \in \mathbb{U}$ et $\frac{1}{z} \in \mathbb{U}$.

</bubble>

En fait, l'ensemble $\mathbb{U}$ permet de décrire tous les points du cercle trigonométrique.

Passons maintenant à l'étude de certains sous-ensembles de $\mathbb{U}$.

<bubble variant="formula">

#### Racines $n$-ièmes de l'unité

Soit $z$ un nombre complexe. On dit que $z$ est une **racine $n$-ième de l'unité** si $z^n = 1$.

De plus, en notant par $\mathbb{U}_n$ l'ensemble des racines $n$-ièmes de l'unité, on a $\displaystyle{\mathbb{U}_n =
\left\{ e^{\frac{2i \times 0}{n}}, e^{\frac{2i \times 1}{n}}, e^{\frac{2i \times 2}{n}}, \dots, e^{\frac{2i \times (n-1)
}{n}} \right\}}$.

</bubble>
