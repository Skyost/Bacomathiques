## Définitions

### Suites numériques

Pour rappel, on appelle **suite** une fonction (et plus précisément application) de $\mathbb{N}$ dans $\mathbb{R}$ :
cette fonction va prendre des éléments de l'ensemble de départ $\mathbb{N}$ et va les amener dans l'ensemble d'arrivée
$\mathbb{R}$.

<bubble variant="formula">

#### Définition

Il y a plusieurs manières de définir une suite :

* **Par récurrence :** On donne le premier terme de la suite ainsi que le terme au rang $n+1$.
* **Par son terme général :** On donne le $n$-ième terme de la suite en fonction de $n$.

</bubble>

**Attention !** Bien que ces deux modes de génération soient les principaux, il en existe d'autres : algorithme, motifs
géométriques, ...

### Sens de variation

<bubble variant="formula">

#### Définition

Soit $(u_n)$ une suite.

* $(u_n)$ est **croissante** si on a $u_{n+1} \geq u_n$ (ou $u_{n+1} - u_n \geq 0$) pour tout $n \in \mathbb{N}$.
* $(u_n)$ est **décroissante** si on a $u_{n+1} \leq u_n$ (ou $u_{n+1} - u_n \leq 0$) pour tout $n \in \mathbb{N}$.
* $(u_n)$ est dite **constante** s'il existe $c \in \mathbb{R}$ tel que $u_n = c$ pour tout $n \in \mathbb{N}$.

</bubble>

Si une suite est croissante ou décroissante et ne change pas de variation, alors elle est dite **monotone**.

### Convergence et divergence

<bubble variant="formula">

#### Convergence

On dit qu'une suite $(u_n)$ **converge** vers un réel $\ell$ quand $n$ tend vers $+\infty$ si :

Pour tout $\epsilon > 0$, l'intervalle ouvert $]\ell-\epsilon, \ell+\epsilon[$, contient tous les termes de la suite $(
u_n)$ à partir d'un certain rang. On note alors : $\lim_{n \rightarrow +\infty} u_n = \ell$.

</bubble>

**Attention !** Il est tout à fait possible que la suite $(u_n)$ converge vers un réel $\ell$ mais ne soit jamais égal à
$\ell$.

<bubble variant="formula">

#### Divergence vers $+\infty$

On dit qu'une suite $(v_n)$ **diverge** vers $+\infty$ quand $n$ tend vers $+\infty$ si :

Pour tout $A \gt 0$, il existe un rang $N$ tel que pour tout $n \geq N$, $v_n \gt A$. On note alors : $\lim_{n
\rightarrow +\infty} u_n = +\infty$.

</bubble>

Il existe une définition similaire pour la divergence vers $-\infty$.

## Calcul de limites

### Limites de suites de référence

Nous allons donner quelques suites classiques avec leur limite en $+\infty$ :

<bubble variant="formula">

#### Limites de suites usuelles

| Suite                                                   | Limite quand $n$ tend vers $+\infty$ |
| ------------------------------------------------------- | ------------------------------------ |
| $(\sqrt{n})$                                            | $+\infty$                            |
| $(n)$                                                   | $+\infty$                            |
| $(n^k)$, pour $k \in \mathbb{N}^*$                      | $+\infty$                            |
| $\left(\frac{1}{\sqrt{n}}\right)$                       | $0$                                  |
| $(\frac{1}{n})$                                         | $0$                                  |
| $\left(\frac{1}{n^k}\right)$, pour $k \in \mathbb{N}^*$ | $0$                                  |

</bubble>

Nous allons désormais donner la limite d'une catégorie de suite très importante en mathématiques : celle des **suites
géométriques**. Ainsi :

<bubble variant="formula">

#### Limite de suites géométriques

Soit $(v_n)$ une suite définie pour tout $n \in \mathbb{N}$ par $v_n = q^n$ (où $q$ est un nombre réel). Alors, on peut
donner la limite de la suite $(v_n)$ en fonction de $q$ :

| Limite d'une suite géométrique                                                                   |
| ------------------------------------------------------------------------------------------------ |
| Si on a...                              | $-1 \lt q \lt 1$ | $1 \lt q$ | $q \leq -1$   | $q = 1$ |
| Alors la suite $(v_n)$ a pour limite... | $0$              | $+\infty$ | Pas de limite | $1$     |

</bubble>

### Opérations sur les limites

Dans tout ce qui suit, $(u_n)$ et $(v_n)$ sont deux suites. Ces tableaux sont à connaître et sont requis pour pouvoir
travailler sur les limites.

<bubble variant="formula">

#### Limite d'une somme

| Limite d'une somme                                                                                                                                 |
| -------------------------------------------------------------------------------------------------------------------------------------------------- |
| Si la limite de $(u_n)$ quand $n$ tend vers $+\infty$ est...          | $\ell$         | $\ell$    | $\ell$    | $+\infty$ | $-\infty$ | $+\infty$ |
| Et la limite de $(v_n)$ quand $n$ tend vers $+\infty$ est...          | $\ell'$        | $+\infty$ | $-\infty$ | $+\infty$ | $-\infty$ | $-\infty$ |
| Alors la limite de $(u_n + v_n)$ quand $n$ tend vers $+\infty$ est... | $\ell + \ell'$ | $+\infty$ | $-\infty$ | $+\infty$ | $-\infty$ | **?**     |

</bubble>

<bubble variant="formula">

#### Limite d'un produit

| Limite d'un produit                                                                                                                                                                                             |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Si la limite de $(u_n)$ quand $n$ tend vers $+\infty$ est...               | $\ell$              | $\ell \gt 0$ | $\ell \gt 0$ | $\ell \lt 0$ | $\ell \lt 0$ | $+\infty$ | $+\infty$ | $-\infty$ | $0$          |
| Et la limite de $(v_n)$ quand $n$ tend vers $+\infty$ est...               | $\ell'$             | $+\infty$    | $-\infty$    | $+\infty$    | $-\infty$    | $+\infty$ | $-\infty$ | $-\infty$ | $\pm \infty$ |
| Alors la limite de $(u_n \times v_n)$ quand $n$ tend vers $+\infty$ est... | $\ell \times \ell'$ | $+\infty$    | $-\infty$    | $-\infty$    | $+\infty$    | $+\infty$ | $-\infty$ | $+\infty$ | **?**        |

</bubble>

<bubble variant="formula">

#### Limite d'un quotient

| Limite d'un quotient                                                                                                                                                                                                                   |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Si la limite de $(u_n)$ quand $n$ tend vers $+\infty$ est...                | $\ell$                              | $\ell$       | $+\infty$     | $+\infty$     | $-\infty$     | $-\infty$     | $\pm \infty$ | $\ell$       | $0$   |
| Et la limite de $(v_n)$ quand $n$ tend vers $+\infty$ est...                | $\ell' \neq 0$                      | $\pm \infty$ | $\ell' \gt 0$ | $\ell' \lt 0$ | $\ell' \gt 0$ | $\ell' \lt 0$ | $\pm \infty$ | $0^+_-$      | $0$   |
| Alors la limite de $(\frac{u_n}{v_n})$ quand $n$ tend vers $+\infty$ est... | $\displaystyle{\frac{\ell}{\ell'}}$ | $0$          | $+\infty$     | $-\infty$     | $-\infty$     | $+\infty$     | **?**        | $\pm \infty$ | **?** |

</bubble>

### Majoration, minoration et bornes

<bubble variant="formula">

#### Définition

Soient une suite $(u_n)$ et deux réels $m$ et $M$ :

* On dit que $m$ est un **minorant** de $(u_n)$ si pour tout $n$ : $u_n \gt m$.
* On dit que $M$ est un **majorant** de $(u_n)$ si pour tout $n$ : $u_n \lt M$.
* On dit que $(u_n)$ est **bornée** si elle est à la fois majorée et minorée.

</bubble>

<bubble variant="formula">

#### Théorème

* Si $(u_n)$ est croissante et est majorée, alors elle est convergente. Si elle n'est pas majorée, $(u_n)$ diverge vers
  $+\infty$.
* Si $(u_n)$ est décroissante et est minorée, alors elle est convergente. Si elle n'est pas minorée, $(u_n)$ diverge
  vers $-\infty$.

</bubble>

### Comparaisons et encadrements

<bubble variant="formula">

#### Théorèmes de comparaison

Soient deux suites $(u_n)$ et $(v_n)$ telles que $u_n \lt v_n$ à partir d'un certain rang $N$. On a :

* Si $\lim\limits_{n \rightarrow +\infty} u_n = +\infty$, alors $\lim\limits_{n \rightarrow +\infty} v_n = +\infty$.
* Si $\lim\limits_{n \rightarrow +\infty} v_n = -\infty$, alors $\lim\limits_{n \rightarrow +\infty} u_n = -\infty$.
* Si $\lim\limits_{n \rightarrow +\infty} u_n = \ell$ et $\lim\limits_{n \rightarrow +\infty} v_n = \ell'$ alors $\ell
  \lt \ell'$.

</bubble>

<bubble variant="formula">

#### Théorème des gendarmes

Soient trois suites $(u_n)$, $(v_n)$ et $(w_n)$. On suppose que $u_n \lt v_n \lt w_n$ à partir d'un certain rang et
que $(u_n)$ et $(w_n)$ convergent vers le réel $\ell$.

Alors $\lim\limits_{n \rightarrow +\infty} v_n = \ell$.

</bubble>

## Raisonnement par récurrence

Si on souhaite montrer qu'une propriété est vraie pour tout $n \in \mathbb{N}$ à partir d'un certain rang $p$, il est
possible d'utiliser un type de raisonnement appelé **raisonnement par récurrence**.

<bubble variant="formula">

#### Raisonnement par récurrence

**Initialisation :** On teste la propriété au rang $p$. Si elle est vérifiée, on passe à l'étape suivante.

**Hérédité :** On suppose la propriété vraie à un rang $n \geq p$. Puis on montre qu'elle reste vraie au rang $n+1$.

**Conclusion :** On explique que l'on vient de démontrer la propriété au rang $n+1$ et que comme celle-ci est
initialisée et héréditaire, alors elle est vraie à partir du rang $p$.

</bubble>
