## L'ensemble des nombres complexes $\mathbb{C}$

### Qu'est-ce que l'ensemble $\mathbb{C}$ ?

<bubble variant="formula">

#### L'ensemble $\mathbb{C}$

Il existe un ensemble de nombres noté $\mathbb{C}$ qui contient l'ensemble $\mathbb{R}$ ainsi qu'un nombre $i \in
\mathbb{C}$ vérifiant $i^2 = -1$.

</bubble>

Cet ensemble est appelé **ensemble des nombres complexes** et obéit aux mêmes règles de calcul que l'ensemble
$\mathbb{R}$.

<bubble variant="tip">

#### Schéma

Il peut être dur de se représenter l'ensemble des nombres complexes, voici un schéma représentant les ensembles de
nombres déjà connus :

![Ensemble des nombres complexes](/img/lessons/terminale/nombres-complexes/ensembles.png)

Comme on peut le voir ici, l'ensemble $\mathbb{C}$ contient l'ensemble $\mathbb{R}$ mais également des nombres qui ne
sont pas réels ($i$, $1 + i$, etc.).

</bubble>

### Forme algébrique d'un nombre complexe

<bubble variant="formula">

#### Forme algébrique

Tout **nombre complexe** $z$ peut s'écrire $z = x+iy$ où $x$ et $y$ sont deux réels. Cette écriture est appelée **forme
algébrique** de $z$. On dit que :

* $x$ est la **partie réelle** de $z$ (notée $\operatorname{Re}(z)$).
* $y$ est la **partie imaginaire** de $z$ (notée $\operatorname{Im}(z)$).

</bubble>

<bubble variant="tip">

Le nombre $z$ est dit **réel** si $y = 0$ et il est dit **imaginaire pur** si $x = 0$.

</bubble>

### Égalité entre nombres complexes

<bubble variant="formula">

#### Lien entre égalité et parties réelle et imaginaire

Deux nombres complexes $z$ et $z'$ sont **égaux** si et seulement si $\operatorname{Re}(z) = \operatorname{Re}(z')$ et
$\operatorname{Im}(z) = \operatorname{Im}(z')$.

</bubble>

Ainsi, pour que deux nombres complexes soient égaux, leur partie réelle et leur partie imaginaire doivent toutes deux
être égales.

<bubble variant="tip">

#### Attention !

Il n'y pas de relation d'ordre dans l'ensemble $\mathbb{C}$. On ne pourra donc pas avoir de relation du type $z \leq
z'$.

</bubble>

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

<bubble variant="tip">

#### Retrouver les formules

Ces propriétés peuvent sembler compliquées mais heureusement il est possible de les retrouver par le calcul. Par
exemple, pour la quatrième propriété, en posant $z = x+iy$ (et donc $\bar{z} = x-iy$) :

$z\bar{z} = (x+iy)(x-iy) = x^2 - ixy + ixy + y^2 = x^2 + y^2 = \left(\sqrt{x^2 + y^2}\right)^2 = |z|^2$.

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

<bubble variant="tip">

Il peut être intéressant pour vous de faire le lien avec
les [fonctions polynômiales du second degré](/cours/premiere/polynomes-second-degre/) vues en Première.

</bubble>

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

<bubble variant="proof" content-width="big">

#### Formule du binôme de Newton

Nous allons prouver cette propriété en utilisant le dénombrement, mais il est tout à fait possible de le faire par
récurrence (c'est d'ailleurs un très bon exercice !)

Ainsi, on a $(a+b)^n = \underbrace{(a + b) \times (a + b) \times \dots \times (a + b)}_{n \text{ fois}}$.

En développant cette expression on peut obtenir une somme de termes de la forme $a^k b^j$ où :

* $k$ représente le nombre de fois où l'on a choisi $a$ en développant.
* $j$ représente le nombre de fois où l'on a choisi $b$ en développant.

Ainsi, forcément, $i = n-k$ (car si on ne choisit pas $a$, alors on choisit $b$ ; choisir $k$ fois $a$ revient donc à
choisir $n-k$ fois $b$).

De plus, il y a $\displaystyle{\binom{n}{k}}$ manières de choisir $k$ fois $a$ parmi les $n$ expressions $(a+b)$, alors
l'expression $a^k b^{n-k}$ apparaît $\displaystyle{\binom{n}{k}}$ lors du développement. Notre somme de termes devient
donc :

$(a+b)^n = \displaystyle{\underbrace{(a^0b^{n-0} + \dots + a^0b^{n-0})}_{\binom{n}{0} \text{ termes}} + \dots + \underbrace{(a^kb^{n-k} + \dots + a^kb^{n-k})}_{\binom{n}{k} \text{ termes}} + \dots + \underbrace{(a^nb^{n-n} + \dots + a^nb^{n-n})}_{\binom{n}{n} \text{ termes}}}$.

C'est ce qu'il fallait démontrer.

</bubble>

<bubble variant="tip" content-width="big">

Si $n = 2$, on retrouve $\displaystyle{(a+b)^2 = \binom{0}{2} a^2 b^0 + \binom{1}{2}a^1 b^1 + \binom{2}{2} a^0 b^2} =
a^2 + 2ab + b^2$.

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

<bubble variant="tip">

#### Exemple

On souhaite résoudre l'équation $-2z^2 + 4z = 10$ dans $\mathbb{C}$.

**1<sup>ère</sup> étape :** On fait apparaître une équation du second degré : $-2z^2 + 4z - 10 = 0$.

**2<sup>ème</sup> étape :** On calcule le discriminant : $\Delta = b^2 - 4ac = 16 - 80 = -64$.

**3<sup>ème</sup> étape :** On transforme le discriminant négatif : $\Delta = 64i^2 = (8i)^2$.

**4<sup>ème</sup> étape :** On trouve les solutions :

$z_1 = \frac{-b - \sqrt{-\Delta}i}{2a} = \frac{-4 - 8i}{2 \times -2} = 1 + 2i$ et $z_2 = \frac{-b + \sqrt{-\Delta}i}{2a}
= \frac{-4 + 8i}{2 \times -2} = 1 - 2i = \bar{z_1}$

</bubble>

<bubble variant="tip">

#### Relation avec les racines d'un polynôme

Résoudre une équation du type $az^2 + bz + c = 0$ (où $a$, $b$ et $c$ sont trois réels et $a \neq 0$) revient à chercher
les racines complexes du polynôme $P$ défini pour tout $z \in \mathbb{C}$ par $P(z) = az^2 + bz + c$.

</bubble>

### Factorisation par $z-a$

<bubble variant="formula">

#### Factorisation par une racine

Soit $P$ un polynôme de degré $n$ et soit $a$ une racine de ce polynôme. Alors il existe un polynôme $Q$ de degré $n-1$
tel que pour tout $z \in \mathbb{C}$, $P(z) = (z-a)Q(z)$.

</bubble>

<bubble variant="tip">

#### Exemple

Factorisons le polynôme $P$ défini pour tout $z \in \mathbb{C}$ par $P(z) = z^3 - z^2 + z - 1$.

On remarque déjà que $P(1) = 1 - 1 + 1 - 1 = 0$. Donc $1$ est racine de $P$, il existe donc un polynôme $Q$ de degré $2$
tel que pour tout $z \in \mathbb{C}$, $P(z) = (z-1)Q(z)$.

Essayons maintenant de déterminer $Q$. Posons $Q(z) = az^2 + bz + c$ et déterminons les coefficients $a$, $b$ et $c$.

Pour tout $z \in \mathbb{C}$, $P(z) = (z-1)Q(z) = (z-1)(az^2 + bz + c) = az^3 + bz^2 + cz - az^2 - bz - c = az^3 + (b-a)
z^2 + (c-b)z - c$.

Il suffit maintenant d'identifier les coefficients (dans la première expression de $P$) :

$\begin{cases} a = 1 \\ b-a = -1 \\ c-b = 1 \\ -c = -1 \end{cases}$

En résolvant le système d'équations :

$\begin{cases} a = 1 \\ b = 0 \\ c = 1 \end{cases}$

Finalement, on a pour tout $z \in \mathbb{C}$, $Q(z) = z^2 + 1$, donc $P(z) = (z-1)(z^2 + 1)$.

Pour terminer la factorisation, il faut également factoriser $Q$. Pour cela on calcule son discriminant qui est donc
$\Delta = -4$ : on a deux racines complexes conjuguées qui sont $z_1 = -i$ et $z_2 = i$.

Finalement, comme $Q$ est de degré $2$ (et qu'on a trouvé deux racines), la factorisation est terminée : on a pour tout
$z \in \mathbb{C}$, $Q(z) = (z-i)(z+i)$ donc $P(z) = (z-1)(z-i)(z+i)$.

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
son [module](#5-module). La **forme trigonométrique** de $z$ est ensuite donnée par : $z = |z| (\cos(\theta) + i\sin(
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

<bubble variant="tip">

#### Exemple

On veut passer le nombre complexe $z = 1 + i$ sous forme exponentielle.

**1<sup>ère</sup> étape :** On calcule le module : $|z| = \sqrt{1^2 + 1^2} = \sqrt{2}$.

**2<sup>ème</sup> étape :** On factorise par le module : $z = \sqrt{2} \times (\frac{\sqrt{2}}{2} + i\frac{\sqrt{2}}{2})
$.

**3<sup>ème</sup> étape :** On calcule l'argument : $\cos(\theta) = \frac{\sqrt{2}}{2}$ et $\sin(\theta) =
\frac{\sqrt{2}}{2}$. On a donc $\theta = \frac{\pi}{4}$ (car $\cos(\frac{\pi}{4}) = \sin(\frac{\pi}{4}) =
\frac{\sqrt{2}}{2}$).

**4<sup>ème</sup> étape :** On passe à la forme exponentielle : $z = \sqrt{2} e^{i\frac{\pi}{4}}$.

</bubble>

On peut étendre l'égalité entre nombres complexes donnée [au début](#3-égalité-entre-nombres-complexes) : deux nombres
complexes sont égaux s'ils ont le **même module** et le **même argument (modulo $2\pi$, nous détaillerons ce point-ci
plus tard)**.

<bubble variant="tip" content-width="big">

#### Formules de Première

Il est possible de
retrouver [les formules trigonométriques](/cours/terminale/fonctions-trigonometriques/#3-formules-de-trigonom%C3%A9trie) vues
en Première à l'aide des nombres de complexes. La démonstration suivante n'est pas à apprendre mais peut être utile pour
retrouver ces formules.

On a $e^{i \times (a + b)} = e^{i \times a} \times e^{i \times b}$.

En passant à la forme trigonométrique, cela donne : $\cos(a + b) + i\sin(a + b) = (\cos(a) + i\sin(a)) \times (\cos(b) +
i\sin(b))$.

Puis en développant : $\cos(a + b) + i\sin(a + b) = \cos(a)\cos(b) + i\cos(a)\sin(b) + i\cos(b)\sin(a) - \sin(a)\sin(b)
$.

Il reste à travailler un petit peu l'expression : $\cos(a + b) + i\sin(a + b) = \cos(a)\cos(b) - \sin(a)\sin(b) + i(
\cos(a)\sin(b) + \cos(b)\sin(a))$.

Or deux nombres complexes sont égaux si et seulement si la partie réelle et la partie imaginaire de ces deux nombres
sont égales, cela donne :

$\begin{cases} \cos(a + b) = \cos(a)\cos(b) - \sin(a)\sin(b) \\ \sin(a + b) = \cos(a)\sin(b) + \cos(b)\sin(a)
\end{cases}$

Les formules vues en Première ont donc bien été retrouvées.

</bubble>

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

<bubble variant="tip">

Le $\mod 2\pi$ signifie simplement que l'on se place **modulo $2\pi$**. Dans cette configuration, on a $-\pi = \pi \mod
2\pi$, mais aussi $-\frac{\pi}{2} = \frac{3 \pi}{2} \mod 2\pi$, ou encore $\pi = 3\pi \mod 2\pi$.

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

<bubble variant="tip">

#### Exemple

On souhaite représenter le point $M$ d'affixe $z = 1 + i$ dans le plan. On a les coordonnées de $M$ qui sont $x = 1$ et
$y = 1$ :

<representation geogebra-id="bej5yp3f"></representation>

</bubble>

<bubble variant="tip">

#### Exemple

On souhaite représenter le point $M'$ d'affixe $z' = \sqrt{2}e^{i\frac{\pi}{4}}$ dans le plan. On a le module de $z'$ :
$|z'| = \sqrt{2}$, et un argument de $z'$ : $\theta = \frac{\pi}{4}$. On va donc tracer le cercle de centre $O$ et de
rayon $\sqrt{2}$ ainsi qu'un segment passant par $O$ et intersectant le cercle en faisant un angle de $\frac{\pi}{4}$
radians avec l'axe des abscisses. Leur intersection sera le point $M'$ :

<representation geogebra-id="vmy38rh2"></representation>

On voit à l'aide de ces deux représentations que $z = z'$ (où $z$ est le nombre complexe de l'exemple précédent), comme
cela a été démontré dans l'exemple de la [première partie](#1-formes-trigonométrique-et-exponentielle).

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

<bubble variant="tip">

#### Lien avec l'affixe d'un point

En fait, pour faire le lien avec la partie précédente, l'affixe d'un point $A$ est tout simplement l'affixe du vecteur
$\overrightarrow{OA}$.

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

<bubble variant="proof">

#### Racines $n$-ièmes de l'unité

Soit $z \in \mathbb{U}_n$. On a $z^n = 1$, donc $|z^n| = |z|^n = 1$. Ainsi, on a $|z| = 1$. En écrivant $z$ sous forme
exponentielle, il existe $\theta \in [0; 2\pi[$ tel que $z = e^{i\theta}$.

Ainsi, $z^n = 1 \iff e^{i n \theta} = 1 = e^{i 0}$. Or, deux nombres complexes sont égaux si et seulement s'ils ont le
même module et le même argument. On doit donc avoir $k \in \mathbb{Z}$ tel que $n \theta = 0 + 2 k \pi$ i.e. $\theta =
\frac{2 k \pi}{n}$.

Et comme par le théorème fondamental de l'algèbre, l'équation $z^n - 1 = 0$ admet au plus $n$ solutions, on a donc
trouvé toutes les solutions.

</bubble>

<bubble variant="tip">

L'ensemble $\mathbb{U}_n$ décrit exactement le polynôme régulier à $n$ côtés inscrit dans le cercle trigonométrique
ayant pour sommet $1$.

Par exemple, $\mathbb{U}_3$ est l'ensemble des sommets du triangle équilatéral inscrit dans le cercle trigonométrique
(dont un sommet est $1$).

</bubble>
