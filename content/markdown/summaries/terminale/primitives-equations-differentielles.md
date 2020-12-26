## Primitives de fonctions continues

### Définition

<bubble variant="formula">

#### Définition

Soit $f$ une fonction définie et continue sur un intervalle $I$. On appelle **primitive** de $f$, toute fonction $F$
définie sur $I$ et qui vérifie pour tout $x \in I$ : $F'(x) = f(x)$.

</bubble>

Ainsi, toute **fonction continue** sur un intervalle admet **une infinité de primitives** d'une forme particulière sur
cet intervalle. Plus formellement :

<bubble variant="formula">

#### Infinité de primitives

Une fonction continue $f$ sur un intervalle $I$ admet une infinité de primitives sur $I$ de la forme $x \mapsto F_0(x) +
c$ avec $c \in \mathbb{R}$ (où $F_0$ est une primitive de $f$).

</bubble>

### Primitive de fonctions usuelles

Le tableau suivant est à connaître (mais il peut être obtenu en prenant celui des dérivées usuelles à l'envers) :

<bubble variant="formula">

Soit $\lambda$ une constante réelle.

| Fonction                                     | Primitive                                  | Domaine de définition de la primitive |
| -------------------------------------------- | ------------------------------------------ | ------------------------------------- |
| $\lambda$                                    | $\lambda x$                                | $\mathbb{R}$                          |
| $e^x$                                        | $e^x$                                      | $\mathbb{R}$                          |
| $\displaystyle{\frac{1}{x}}$                 | $\ln(x)$                                   | $\mathbb{R}^{*}_{+}$                  |
| $\displaystyle{\frac{1}{\sqrt{x}}}$          | $2\sqrt{x}$                                | $\mathbb{R}^{*}_{+}$                  |
| $x^a$ avec $a \in \mathbb{R}$ et $a \neq -1$ | $\displaystyle{\frac{1}{a + 1} x^{a + 1}}$ | $\mathbb{R}^{*}_{+}$                  |
| $\sin(x)$                                    | $-\cos(x)$                                 | $\mathbb{R}$                          |
| $\cos(x)$                                    | $\sin(x)$                                  | $\mathbb{R}$                          |

</bubble>

### Opérations sur les primitives

Le tableau suivant est également à connaître (mais il peut être obtenu en prenant celui des dérivées usuelles à
l'envers) :

<bubble variant="formula">

Soit $u$ une fonction continue.

| Fonction                                          | Primitive                                  | Domaine de définition de la primitive                                                                     |
| ------------------------------------------------- | ------------------------------------------ | --------------------------------------------------------------------------------------------------------- |
| $u'e^u$                                           | $e^u$                                      | En tout point où $u$ est définie.                                                                         |
| $\displaystyle{\frac{u'}{u}}$                     | $\ln(\|u\|)$                               | En tout point où $u$ est définie et est non-nulle. On peut retirer la valeur absolue si $u$ est positive. |
| $\displaystyle{\frac{u'}{\sqrt{u}}}$              | $2\sqrt{u}$                                | En tout point où $u$ est définie et est strictement positive.                                             |
| $u' (u)^a$ avec $a \in \mathbb{R}$ et $a \neq -1$ | $\displaystyle{\frac{1}{a + 1} u^{a + 1}}$ | En tout point où $u$ est définie.                                                                         |
| $u' \sin(u)$                                      | $-\cos(u)$                                 | En tout point où $u$ est définie.                                                                         |
| $u' \cos(u)$                                      | $\sin(u)$                                  | En tout point où $u$ est définie.                                                                         |

</bubble>

## Équations différentielles

### Qu'est-ce-qu'une équation différentielle ?

Commençons cette partie par quelques définitions.

<bubble variant="formula">

#### Définition

* Une **équation différentielle** est une égalité liant une fonction inconnue $y$ à ses dérivées successives ($y'$, $y''
  $, ...) contenant éventuellement d'autres fonctions connues.
* Une **solution** d'une équation différentielle est une fonction vérifiant l'égalité décrite précédemment.

</bubble>

### Résolution d'équations différentielles de la forme $y'=ay$

Nous allons donner une formule permettant de résoudre des équations différentielles de la forme $y' = ay$.

<bubble variant="formula">

#### Formule

On pose $(E) : y'=ay$ (où $a$ est un réel). Alors l'ensemble des solutions de $(E)$ est l'ensemble des fonctions $x
\mapsto c e^{ax}$ où $c \in \mathbb{R}$.

</bubble>

<bubble variant="formula">

#### Théorème

Pour tout réels $x_0$ et $y_0$, il existe une **unique** fonction $y$ solution de l'équation différentielle $(E)$ telle
que $y(x_0) = y_0$.

</bubble>

### Résolution d'équations différentielles de la forme $y'=ay+b$

Nous allons donner une formule permettant de résoudre des équations différentielles de la forme $y' = ay+b$.

<bubble variant="formula">

#### Formule

On pose $(E) : y'=ay+b$ (où $a$ est un réel non-nul et $b$ est un réel). Alors l'ensemble des solutions de $(E)$ est
l'ensemble des fonctions $x \mapsto c e^{ax} - \frac{b}{a}$ où $c \in \mathbb{R}$.

</bubble>

<bubble variant="formula">

#### Théorème

Pour tout réels $x_0$ et $y_0$, il existe une **unique** fonction $y$ solution de l'équation différentielle $(E)$ telle
que $y(x_0) = y_0$.

</bubble>
