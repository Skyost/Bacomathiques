## Graphe pondéré et graphe probabiliste

### Définition

<bubble variant="formula">

#### Graphe pondéré

Un graphe est dit **pondéré** si chacune de ses arêtes est affecté d'un nombre positif (ou nul) que l'on appelle
**poids**.

Le poids d'une chaîne (ou d'un chemin) est la somme des poids de ses arêtes.

</bubble>

<bubble variant="formula">

#### Graphe probabiliste

On appelle **graphe probabiliste** un graphe orienté et pondéré tel que :

* Pour chaque sommet, la somme des poids des arcs issus de ce sommet vaut $1$.
* Il y a au plus $1$ arrête orientée reliant chaque sommet.

</bubble>

Il peut être utile de faire l'analogie entre les graphes probabilistes
et [les arbres de probabilité](/cours/premiere/probabilites/#2-arbre-de-probabilit%C3%A9) vus en classe de Première.

### Matrice de transition

<bubble variant="formula">

#### Définition

Soit $G$ un graphe probabiliste d'ordre $n$. On appelle **matrice de transition** du graphe $G$, la matrice carrée
d'ordre $n$ dont le coefficient à la ligne $i$ et à la colonne $j$ est égal au poids de l'arête reliant le sommet $i$ au
sommet $j$.

Une telle matrice est qualifiée de **stochastique** car la somme des coefficients de chacune de ses lignes vaut $1$.

</bubble>

Attention cependant à ne pas confondre matrice de transition et matrice d'adjacence.

## Chaînes de Markov

### Qu'est-ce qu'une chaîne de Markov ?

Il vous est fortement conseillé de relire (et de maîtriser) le cours
sur [les variables aléatoires](/cours/terminale/variables-aleatoires-concentration-grands-nombres/) avant d'aborder
cette section. De plus, sachez que cette partie est sans doute la plus difficile du programme de Terminale. Mais ne vous
découragez pas car elle reste parfaitement accessible !

<bubble variant="formula">

#### Définition

Soit $(X_n)$ une suite de variables aléatoires discrètes définies sur un même univers $\Omega$ et à valeurs dans un
ensemble $E$. On dit que $(X_n)$ définit une **chaîne de Markov** sur $E$ si pour tout $n \in \mathbb{N}$ et tout $x_0,
x_1, x_2, \dots, x_n \in E$, l'événement $(X_n = x_n)$ ne dépend que de l'événement antérieur $(X_{n-1} = x_{n-1})$ (et
pas des précédents) ; autrement dit, si $p_{(X_{n-1} = x_{n-1}) \, \cap \dots \cap \, (X_0 = x_0)}(X_n = x_n) = p_{(X_
{n-1} = x_{n-1})}(X_n = x_n)$.

De plus, l'ensemble $E$ est appelé **espace des états** de la chaîne de Markov.

</bubble>

En français, cela signifie que si $X_n$ représente l'état d'un système à un temps $n$, alors l'état suivant $X_{n+1}$ ne
dépend que de l'état au temps $n$ et pas des états précédents.

De plus, notez bien que nous n'avons pas fait d'hypothèse sur le cardinal de $E$ (qui peut donc être de cardinal $m \in
\mathbb{N}$). En classe de Terminale, nous nous limiterons principalement au cas où $E$ possède $2$ voire $3$ éléments.

<bubble variant="formula">

#### Chaîne de Markov homogène

Soit $(X_n)$ une chaîne de Markov dont on note $E$ l'espace des états. Alors $(X_n)$ est dite **homogène** si pour tout
$n \in \mathbb{N}$ et pour tout $x$, $y \in E$, la probabilité $p_{(X_n = x)}(X_{n+1} = y)$ est indépendante de $n$.

En termes mathématiques, cela signifie que pour tout $n \in \mathbb{N}$ et pour tout $x$, $y \in E$, $p_{(X_n = x)}(X_
{n+1} = y) = p_{(X_0 = x)}(X_1 = y)$.

</bubble>

### Matrice et graphe associés à une chaîne de Markov

<bubble variant="formula">

#### Matrice de transition

Soit $(X_n)$ une chaîne de Markov homogène dont on note $E = \{x_1, x_2, \dots, x_m\}$ l'espace des états. La **matrice
de transition** de $(X_n)$ est la matrice carrée d'ordre $m$ dont le coefficient situé à la $i$-ième ligne et à la
$j$-ième colonne est égal à $p_{i,j} = p_{(X_n = x_i)}(X_{n+1} = x_j)$.

</bubble>

<bubble variant="formula">

#### Graphe associé à une chaîne de Markov

Soit $(X_n)$ une chaîne de Markov homogène dont on note $E = \{x_1, x_2, \dots, x_m\}$ l'espace des états. On associe à
cette chaîne de Markov un graphe probabiliste $G$ d'ordre $m$ dont les sommets sont les états $x_i$ et dont les arêtes
$x_i - x_j$ sont pondérées par les poids $p_{i,j} = p_{(X_n = x_i)}(X_{n+1} = x_j)$.

La matrice de transition de $(X_n)$ est égale à la matrice de transition du graphe probabiliste $G$ : il s'agit donc
aussi d'une matrice stochastique.

</bubble>

### Distributions dans une chaîne de Markov

<bubble variant="formula">

#### Proposition

Soit $(X_n)$ une chaîne de Markov homogène dont on note $E = \{x_1, x_2, \dots, x_m\}$ l'espace des états. On pose $p_
{i,j}^{(k)} = p_{(X_0 = x_i)}(X_k = x_j)$ pour tout $k \in \mathbb{N}^\*$ (qui représente la probabilité que la chaîne
de Markov $(X_n)$ passe de l'état $x_i$ à l'état $x_j$ en $k$ étapes). On a :

$\displaystyle{p_{i,j}^{(k)} = \sum_{q=1}^m p_{i,q}^{(k-1)} \times p_{q,j}^{(1)} = p_{i,1}^{(k-1)} \times p_{1,j}^{(1)}
+ p_{i,2}^{(k-1)} \times p_{2,j}^{(1)} + \dots + p_{i,m}^{(k-1)} \times p_{m,j}^{(1)}}$.

De plus, comme $(X_n)$ est homogène, $p_{i,j}^{(k)} = p_{i,j}^{(n+k)}$ pour tout $n \in \mathbb{N}$.

</bubble>

Cette formule semble un petit peu compliquée à interpréter. Elle signifie simplement que la probabilité que la chaîne de
Markov $(X_n)$ passe de l'état $x_i$ à l'état $x_j$ en $k$ étapes est égale à la probabilité qu'elle passe de l'état
$e_i$ à $e_q$ en une étape, puis de passer de $e_q$ à $e_j$ en $k-1$ étapes. Heureusement, il est possible de la
simplifier grandement à l'aide des matrices de transition.

<bubble variant="formula">

#### Lien avec la matrice de transition

En reprenant les notations précédentes et en notant $M$ la matrice de transition de $(X_n)$, on a que $p_{i,j}^{(k)}$
est le coefficient à la ligne $i$ et à la colonne $j$ de la matrice $M^k$.

</bubble>

Enfin, donnons la définition centrale de cette section.

<bubble variant="formula" content-width="big">

#### Définition

Soit $(X_n)$ une chaîne de Markov homogène dont on note $E = \{x_1, x_2, \dots, x_m\}$ l'espace des états. On appelle
**suite des distributions** de $(X_n)$ la suite de matrices $(\pi_n)$, définie pour tout $n \in \mathbb{N}$ par
$\displaystyle{\pi_n = \begin{pmatrix} p(X_n = x_1) & p(X_n = x_2) & \dots & p(X_n = e_m) \end{pmatrix}}$.

$\pi_n$ est donc une matrice ligne d'ordre $m$ et est appelée **distribution au temps $n$**.

$\pi_0$ (la distribution au temps $0$) est appelée **distribution initiale**.

</bubble>

Une propriété très sympathique des distributions, est que l'on dispose d'une relation de récurrence permettant de
calculer facilement la distribution à un temps $n$ donné.

<bubble variant="formula">

#### Relation entre $\pi_{n+1}$ et $\pi_n$

En reprenant les notations de la définition précédente et en notant $M$ la matrice de transition de $(X_n)$, on a que la
suite $(\pi_n)$ vérifie une relation de récurrence donnée pour tout $n \in \mathbb{N}$ par $\pi_{n+1} = \pi_n M$.

On en déduit que pour tout $n \in \mathbb{N}$, $\pi_n = \pi_0 M^n$.

</bubble>

### Distribution invariante

<bubble variant="formula">

#### Définition

Soit $(X_n)$ une chaîne de Markov homogène de matrice de transition $M$. Une distribution $\pi$ est **invariante** si
les deux conditions suivantes sont respectées :

* $\displaystyle{\pi M = \pi}$ (donc si $\pi$ est une distribution à un temps $n$, on a $\pi = \pi_n$ et cette condition
  se résume à avoir $\pi_n = \pi_n M = \pi_{n+1}$).
* La somme des coefficients de $\pi$ vaut $1$.

</bubble>

<bubble variant="formula">

#### Existence et unicité de la distribution invariante au temps $n$

Soit $(X_n)$ une chaîne de Markov homogène de matrice de transition $M$.

Si $M$ ne possède aucun coefficient non nul autre que sur sa diagonale, alors $(X_n)$ admet une unique distribution
invariante $\pi$.

</bubble>

<bubble variant="formula">

#### Convergence de la distribution

Soit $(X_n)$ une chaîne de Markov homogène dont on note $(\pi_n)$ la suite des distributions.

* Si $(\pi_n)$ est une suite de matrices convergente, alors elle converge vers une distribution invariante $\pi$.
* Si le cardinal de l'ensemble des états de $(X_n)$ est $2$, alors $(\pi_n)$ est convergente (et converge vers la
  distribution invariante $\pi$).

</bubble>
