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

<bubble variant="tip">

#### Exemple

On définit les suites $(u_n)$ et $(v_n)$ ainsi :

* $u_n = n$ pour tout $n \in \mathbb{N}$ ($(u_n)$ est définie par son terme général).
* $(v_n) = \begin{cases} v_0 = 0 \\ v_{n+1} = v_n + 1 \text{ pour tout } n \geq 1 \end{cases}$ ($(v_n)$ est définie par
  récurrence).

On remarque que bien que définies différemment, $(u_n)$ et $(v_n)$ sont égales.

</bubble>

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

<bubble variant="tip">

Cette définition est un peu abstraite mais elle signifie simplement que $u_n$ se rapproche autant que l'on veut de $l$
pourvu que $n$ soit assez grand.

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

<bubble variant="tip">

#### Divergence vers $-\infty$

Dire que $(v_n)$ **diverge** vers $-\infty$ signifie que :

Pour tout $A \gt 0$, il existe un rang $N$ tel que pour tout $n \geq N$, $v_n \lt -A$. On note alors : $\lim_{n
\rightarrow +\infty} u_n = -\infty$.

</bubble>

<bubble variant="tip">

À noter que l'on n'étudie les limites des **suites** que quand $n$ tend vers $+\infty$, et qu'il est possible qu'une
suite n'admette pas de limite. On dit alors que cette suite **diverge**. Par contre, si une suite converge vers une
limite, alors cette limite est **unique**.

</bubble>

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

<bubble variant="tip">

Le réel $q$ est la **raison** de la suite : si $q \gt 1$, $(v_n)$ est strictement croissante, si $0 \lt q \lt 1$, $(v_n)
$ est strictement décroissante et si $q = 1$ ou $0$, $(v_n)$ est constante.

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

<bubble variant="tip">

#### Formes indéterminées

À noter qu'il n'existe que 4 formes indéterminées : $+\infty - \infty$, $0 \times \pm \infty$, $\frac{\pm \infty}{\pm
\infty}$ et $\frac{0}{0}$.

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

<bubble variant="proof">

Il faut savoir montrer que toute suite croissante et non majorée diverge vers $+\infty$. C'est ce que nous allons faire
ici. Soit donc $(u_n)$ une telle suite. Soit $A > 0$, on cherche un rang $N$ tel que pour tout $n \geq N$, $u_n \gt A$.

Or, comme $(u_n)$ est non majorée, il existe $N$ tel que $u_N > A$. De plus, comme $(u_n)$ est croissante, alors $A \lt
u_N \leq u_{N+1} \leq u_{N+2} \leq \dots$

Donc on a bien trouvé notre rang $N$ vérifiant la définition de la divergence vers $+\infty$.

</bubble>

<bubble variant="tip">

Toute suite convergente est également bornée.

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

<bubble variant="proof">

Il peut être utile de savoir démontrer le premier point dans le cas $N = 0$ (les autres points se démontrent de manière
semblable). Supposons $\lim\limits_{n \rightarrow +\infty} u_n = +\infty$. Soit $A > 0$, on cherche un rang $p$ tel que
pour tout $n \geq p$, $v_n \gt A$.

Comme $u_n$ diverge vers $+\infty$, il existe un rang $q$ tel que pour tout $n \geq q$, $u_n \gt A$. Donc on a : $A \lt
u_q \lt v_q$, mais aussi $A \lt u_{q+1} \lt v_{q+1}$, etc.

Donc il suffit de poser $p = q$ et on a bien notre rang vérifiant la définition de la divergence vers $+\infty$.

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

<bubble variant="tip">

#### Exemple

Soit une suite $(u_n)$ définie par $(u_n) = \begin{cases} u_0 = 4\\ u_{n+1} = \frac{4u_n + 17}{u_n + 4}\end{cases}$. On
souhaite montrer que pour tout $n \in \mathbb{N}$, on a $4 \leq u_n \leq 5$.

On note $\mathcal{P}_n$ la propriété définie pour tout $n \in \mathbb{N}$ par $\mathcal{P}_n$ : $4 \leq u_n \leq 5$.

On constate que $u_{n+1} = \frac{4u_n + 17}{u_n + 4} = \frac{4(u_n + 4) + 1}{u_n + 4} = 4 + \frac{1}{u_n + 4}$.

**Initialisation :** On teste la propriété au rang $0$ :

$\mathcal{P}_0$ : $4 \leq u_0 \leq 5 \iff 4 \leq 4 \leq 5$. C'est vrai : la propriété est vraie au rang $0$.

**Hérédité :** Supposons la propriété vraie à un rang $n \in \mathbb{N}$ et vérifions qu'elle est vraie au rang $n+1$.

D'après $\mathcal{P}_n$ : $4 \leq u_n \leq 5$. Donc on a :

$\iff 4 \leq u_n \leq 5$

$\iff 4 + 4 \leq u_n + 4 \leq 5 + 4$

$\iff \frac{1}{9} \leq \frac{1}{u_n + 4} \leq \frac{1}{8}$ (la fonction inverse est décroissante sur $\mathbb{R}^+$ donc
on change de sens l'inégalité)

$\iff 4 + \frac{1}{9} \leq 4 + \frac{1}{u_n + 4} \leq 4 + \frac{1}{8}$

Or $4 + \frac{1}{9} \approx 4.111 \gt 4$ et $4 + \frac{1}{8} = 4.125 \lt 5$. On a donc bien :

$4 \leq u_{n+1} \leq 5$

**Conclusion :** La propriété est initialisée au rang $0$ et est héréditaire. Ainsi, $\mathcal{P}_n$ est vraie pour tout
$n \in \mathbb{N}$.

</bubble>

Le raisonnement par récurrence est très utilisé en mathématiques et ne se limite pas qu'à l'étude des suites. On peut
par exemple l'utiliser pour montrer l'**inégalité de Bernoulli**.

<bubble variant="formula">

#### Inégalité de Bernoulli

$(1 + x)^n \gt 1 + nx$ pour tout $n \geq 2$ et tout $x \in [-1, 0[ \, \cup \, ]0, +\infty[$.

</bubble>

<bubble variant="proof">

#### Inégalité de Bernoulli

Soit $x \in [-1, 0[ \, \cup \, ]0, +\infty[$. On note $\mathcal{P}_n$ la propriété définie pour tout $n \geq 2$ par
$\mathcal{P}_n$ : $(1+x)^n \gt 1+nx$. Montrons $\mathcal{P}_n$ par récurrence.

**Initialisation :** On teste la propriété au rang $2$ :

$\mathcal{P}_2$: $(1+x)^2 = 1 + 2x + x^2 \gt 1 + 2x$ (car $x^2 \gt 0$).

La propriété est vraie au rang $2$.

**Hérédité :** Supposons la propriété vraie à un rang $n \geq 2$ et vérifions qu'elle est vraie au rang $n+1$.

En multipliant les deux membres de l'inégalité de l'hypothèse de récurrence par $1+x \geq 0$ (qui ne change donc pas le
sens de l'inégalité), on obtient :

$(1+x)^n (1+x) \geq (1+nx)(1+x)$  
$\iff (1+x)^{n+1} \geq 1 + (n+1)x + nx^2 \gt 1 + (n+1)x$

**Conclusion :**

La propriété est initialisée au rang $2$ et est héréditaire. Ainsi, $\mathcal{P}_n$ est vraie pour tout $n \geq 2$.

</bubble>
