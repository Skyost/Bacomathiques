## Probabilités conditionnelles

### Définition

<bubble variant="formula">

#### Définition

Soient $A$ et $B$ deux événements avec $A$ de probabilité non nulle. Alors **la probabilité conditionnelle de $B$
sachant que $A$ est réalisé** (notée $p_{A}(B)$) est $\displaystyle{p_{A}(B) = \frac{p(A \cap B)}{p(A)}}$.

</bubble>

<bubble variant="formula">

#### Indépendance

Deux événements $A$ et $B$ sont dits **indépendants** si la réalisation de l'un n'a aucune incidence sur la réalisation
de l'autre et réciproquement. C'est-à-dire si $p(A \cap B) = p(A) \times p(B)$.

</bubble>

<bubble variant="formula">

#### Propriétés

Pour deux événements indépendants $A$ et $B$, on a les relations suivantes :

* $p_{A}(B) = p(B)$
* $p_{B}(A) = p(A)$

</bubble>

### Arbre de probabilité

Au lycée, pour représenter visuellement des probabilités on utilise très souvent un **arbre de probabilité**. Nous nous
limiterons ici au cas de deux événements, mais il est possible d'en rajouter encore d'autres.

Ainsi :

<bubble variant="formula">

#### Définition

Soient $A$ et $B$ deux événements. L'arbre de probabilité décrivant la situation est le suivant :

![Arbre de probabilité](/img/lessons/premiere/probabilites/arbre.svg)

</bubble>

La somme (dans le sens vertical) des probabilités de chacune des branches ayant une racine commune doit toujours faire
$1$.

### Formule des probabilités totales

Voici maintenant l'énoncé de la **formule des probabilités totales**, qui peut être très utile pour calculer des
probabilités que l'on ne connaît pas (ou qui ne sont pas données dans un énoncé d'exercice) :

<bubble variant="formula">

#### Formule des probabilités totales

Soient $A_1, A_2, ..., A_n$ des événements qui partitionnent (qui recouvrent) l'univers $\Omega$, alors pour tout
événement $B$ :

$p(B) = p(B \cap A_1) + p(B \cap A_2) + \dots + p(B \cap A_n)$

</bubble>

## Variables aléatoires

### Définition

<bubble variant="formula">

#### Définition

Une **variable aléatoire** $X$ est une fonction qui, à chaque événement élémentaire de l'univers $\Omega$ y associe un
nombre réel. C'est-à-dire : $X : \Omega \rightarrow \mathbb{R}$.

</bubble>

L'ensemble des valeurs prises par $X$ est noté $X(\Omega)$.

### Loi de probabilité

<bubble variant="formula">

#### Définition

Soit $X$ une variable aléatoire. La **loi de probabilité** de $X$ attribue à chaque valeur $x_i$ la probabilité $p_i =
p(X = x_i)$ de l'événement $X = x_i$ constitué de tous les événements élémentaires dont l'image par $X$ est $x_i$.

</bubble>

On représente généralement les lois de probabilité par un tableau.

<bubble variant="formula">

#### Représentation d'une loi de probabilité par un tableau

Soit $X$ une variable aléatoire. On peut représenter sa loi de probabilité par le tableau ci-contre :

| $x_i$                 | $x_1$                 | $x_2$                 | ... | $x_n$                 |
| --------------------- | --------------------- | --------------------- | --- | --------------------- |
| $p_i$ $= p(X = x_i)$ | $p_1$ $= p(X = x_1)$ | $p_2$ $= p(X = x_2)$ | ... | $p_n$ $= p(X = x_n)$ |

On a $p_1 + p_2 + \dots + p_n = 1$.

</bubble>

### Espérance, variance et écart-type

<bubble variant="formula">

#### Espérance

L'**espérance** $E(X)$ d'une variable aléatoire $X$ est le réel :

$E(X) = x_1 \times p_1 + x_2 \times p_2 + \dots + x_n \times p_n$.

</bubble>

<bubble variant="formula">

#### Variance et écart-type

La **variance** $V(X)$ et l'**écart-type** $\sigma(X)$ d'une variable aléatoire $X$ sont les réels positifs suivants :

* $V(X) = E(X^2) - E(X)^2$
* $\sigma(X) = \sqrt{V(X)}$

</bubble>

Chacun de ces paramètres a une utilité bien précise. En effet :

<bubble variant="formula">

#### Signification des paramètres

* L'espérance est la **valeur moyenne** prise par $X$.
* La variance et l'écart-type mesurent la **dispersion** des valeurs prises par $X$. Plus ces valeurs sont grandes, plus
  les valeurs sont dispersées autour de l'espérance.

</bubble>
