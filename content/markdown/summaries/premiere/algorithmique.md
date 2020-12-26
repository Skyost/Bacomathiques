## Définition

**Un algorithme** est une suite finie et ordonnée d’opérations ou d'instructions permettant de résoudre un problème ou
d'obtenir un résultat. Ainsi, faire une recette de cuisine ou encore effectuer une division euclidienne à la main sont
des exemples d'algorithmes.

Dans ce cours, nous travaillerons à la fois avec des algorithmes [Python](https://python.org) et des algorithmes en
pseudo-code.

## Instructions

### Création de variables

**Créer une variable** permet de réserver un espace pour y stocker des données quelconques.

On donne un nom à chaque espace pour le repérer : ce sont les noms de variables.

Dans certains langages, on leur donne également un type (entier, réel, ...) pour travailler avec (ce qui n'est pas le
cas dans Python).

<bubble variant="formula">

#### En python

```python
nombre = 0 # On crée la variable "nombre" et on lui assigne la valeur 0. chaine = 'Bonjour' # On crée la variable "chaine" et on lui assigne la valeur 'Bonjour'.
```

</bubble>

### Affections de valeurs

Comme dit précédemment, les variables sont des espaces dans lequel il est possible de stocker des informations.

Cependant, après avoir créé cet espace, celui-ci est encore vide. C'est pourquoi on doit le remplir : c'est **
l'affectation d'une valeur à une variable**.

Il existe plusieurs manières d'affecter une valeur à une variable : soit on lui donne directement sa valeur dans
l'algorithme, soit on demande à l'utilisateur d'entrer une valeur (il faut garder à l'esprit que nos algorithmes sont
faits pour être utilisés par des utilisateurs).

<bubble variant="formula">

#### En python

```python
x = int(input('Veuillez entrer une valeur : ')) # L'utilisateur va entrer une valeur, on va la convertir en entier et on va affecter celui-ci à notre variable "x".
y = 2*x + 10 # Une fois fait, "y" va prendre la valeur 2 * x + 10. Par exemple, si l'utilisateur entre "10", "y" vaudra 30.
```

</bubble>

Une fois que l'on a affecté une valeur à une variable, il est encore possible de la changer !

### Affichage de variables

Nos algorithmes étant faits pour être utilisés, il faut donc **retourner un résultat** sinon ceux-ci seraient inutiles.

C'est pourquoi, on peut afficher les valeurs des variables (les montrer à l'utilisateur).

<bubble variant="formula">

#### En python

```python
print('Voici la valeur de "maVariable" :', maVariable) # Permet d'afficher la valeur de "maVariable".
```

</bubble>

## Blocs d'instructions

### Définition

Les blocs d'instructions sont des parties de l'algorithme (ce sont des algorithmes dans l'algorithme) qui s'exécutent
suivant certaines conditions propres aux différents blocs d'instructions.

### Les blocs SI et SINON

Les blocs **SI** et **SINON** sont des blocs d'instructions très utilisés qui permettent de tester une condition : si
elle est réalisée, on va exécuter les instructions se situant sous le bloc SI et sinon, on va exécuter celles se situant
sous le bloc SINON.

<bubble variant="formula">

#### En python

```python
x = 2 # On attribue à "x" la valeur 2.
if x == 3: # Si "x" est égal à 3...
    print('"x" est égal à 3.') # ... Alors on affiche ce message. Mais ici, "x" vaut 2 donc ce message ne sera jamais affiché.
else: # Sinon...
    print('"x" n\'est pas égal à 3.') # ... On affiche ce message.
```

</bubble>

### La boucle POUR

La **boucle POUR** est un bloc d'instruction qui s'exécute et qui va faire prendre à une variable toutes les valeurs
comprises dans un ensemble d'entiers.

<bubble variant="formula">

#### En python

```python
for i in range(-5, 6): # Pour chaque entier entre -5 (inclus) et 6 (exclu)...
    print(i) # ... On affiche cet entier.
```

</bubble>

### La boucle TANT QUE

Cette boucle, différente de la boucle POUR, permet d'exécuter son bloc d'instructions tant qu'une certaine condition est
valable.

<bubble variant="formula">

### En python

```python
x = 100 # On affecte à "x" la valeur 100.
while x > 10: # Tant que x est supérieur à 10...
    x = x / 2 # On divise x par 2 (i.e. on affecte à "x" la valeur x/2).
    print(x) # On affiche la valeur de "x".
```

</bubble>
