# 1.ELIXIR : Basics
http://elixir-lang.org/

Langage de programmation orienté programmation fonctionnelle.

### Mix
 Outil en ligne de commande permettant de :
 1. Créer un nouveau projet
 2. Compiler un projet
 3. Exécuter des tâches
 4. Gérer les dépendances
 
### Créer son premier projet Elixir
Pour créer son premier projet Elixir, il est recommandé d'utiliser la commande suivante :
`mix new nom_du_projet`

### Elixir dans le terminal
Pour tester Elixir dans un terminal, il est possible d'éxécuter un interpréteur Elixir au travers de la commande :
`iex`
  
Pour tester notre projet Elxir dans un terminal, il est nécessaire d'ajouter des options à la commande précédente, afin de compiler notre projet, pour que ce dernier soit accessible dans le terminal.
`iex -S mix`
  
Pour forcer la recompilation du code, lorsque l'on vient de mettre à jour notre code, ou d'ajouter une nouvelle fonction, il est possible d'utliser la commande :
`recompile`
  
Pour quitter le shell Elixir, tapper la commande `Ctrl + c`, deux fois.
  
### Comment opérer avec le compilateur
#### Première option
    > iex
    > c("my_elixir_file.ex")
    > MyModule.my_function()
    
#### Seconde option
    > elixir "my_elixir_file.ex"
    
#### Besoin d'aide?
    > h Module
    > h Module.function
    > h Module.function/arity
    
#### Afficher variable
    > IO.puts nom_de_la_variable
    > IO.inspect nom_de_la_variable

### Programmation Orientée Objet VS Programmation Fonctionnelle

### Types de données
 * Integer => 1
 * Float => 1.0
 * Atom => :atom
 * Booleans => true/false
 * List => [1, 2, 3]
 * Tuple => {1, 2, 3}
 * String => "string"
 * Function => fn() -> "hello" end
 * Keyword List => [a: "a"] == [{:a, "a"}]
 
#### Underscore variable
La variable est utilisée pour des fonctions dites impures. 
Ce n\'est pas ce que retourne la fonction qui est important, mais c'est l\'action qui est exécutée par la fonction.
Ex: écrire un nouvel élement en base de données.

#### Lists
    iex> [head|tail] = [1, 2, 3]
    [1, 2, 3]
    
    iex> 1 = head
    1
    
    iex> [2, 3] = tail
    [2, 3]
    
    iex> list = [1 | [2 | [3 | []]]]
    [1, 2, 3]
    
    iex> [0 | list]
    [0, 1, 2, 3]
    
#### Tuples
    iex> tuple = {:ok, "hello"}
    {:ok, "hello"}
    
    iex> elem(tuple, 1)
    "hello

#### Module & Functions
    defmodule BasicMath do
      def add(x, y) do
        x + y
      end
      
      def add_square(x, y) do
        square(x) + square(y)
      end
      
      #Fonction privée
      defp square(x) do
        x * x
      end
    end
    
    BasicMath.add_square(2, 2)
    
#### Functions and Pattern Matching
    defmodule Say do
      def hello("world") do
        "No way, I can't say hello world anymore!"
      end
      
      def hello(name) do
        # <> utilisé pour concaténer des strings
        "Hello " <> name
      end
    end
    
    Say.hello("world")
    # return "No way, I can't say hello world anymore!"
    Say.hello("John Doe")
    # return "Hello John Doe"
    
#### Pattern Loop Matching
    defmodule LoopOver do
      def this_list([]), do: IO.puts "DONE"
      def this_list([head|tail]) do
        IO.puts head
        this_list(tail)
      end
    end
    
    LoopOver.this_list([1, 2, 3])
    

#### Pipe Operator
Le symbole `|>` est très utilisé pour factoriser le code en Elixir.
Il prend le résultat d'une expression ou fonction située à sa gauche, et le passe en tant que premier argument de l'expression ou fonction située à droite.

Exemple : 

    Dans cet exemple nous supposerons que nous souhaitons réaliser une nouvelle fonction permettant de créer une main pour un jeu de carte.
    Nous partons du principe que les fonctions de base ont déjà été créées (create_deck, shuffle, deal).
    
    def create_hand(hand_size) do
      # OLD CODE : without Pipe Operator
      deck = Cards.create_deck
      deck = Cards.shuffle(deck)
      hand = Cards.deal(deck, hand_size)

      # NEW CODE : refactor the code with the Pipe Operator
      Cards.create_deck
      |> Cards.shuffle
      |> Cards.deal(hand_size)
    end
    


# 2.ELIXIR : Documenter son code en Elixir

Elixir propose un outil trés puissant pour créer une documentation, et ainsi expliquer chaques parties du programme.

### Ajouter le package "ex_doc" aux dépendances
Pour ajouter le package, éditer le fichier mix.exs situé à la racine du projet, et ajouter ex_doc aux dépendances

    defp deps do
      [
        {:ex_doc, "~> 0.12"}
      ]
    end

### Télécharger et installer "ex_doc"
Pour installer le package ex_doc, éxécuter la commande ci-dessous :
`mix deps.get`

### Inscrire la documentation
#### Documentation pour le module
Pour ajouter la documentation au sein d'un module, éditer son fichier .ex et inscrire les informations souhaitées en respectant la syntaxe suivante :

    @moduledoc """
      C'est ici que l'on place le texte de la documentation du module
    """

#### Documentation pour les fonctions
Pour ajouter de la documentation à propos d'une fonction, éditer son fichier .ex, et inscrire les informations souhaitées juste au dessus de la fonction, en respectant la syntaxe suivante :

    @doc """
      C'est ici que l'on place le texte de la documentation de la fonction
     """

### Générer la documentation
Pour générer la documentation, il est nécessaire d'exécuter la commande suivante :
`mix docs`

Ceci a pour but de générer un fichier html (nom_du_projet/doc/index.html), avec une mise en forme semblable à la documentation officielle d'Elixir. 


# 3.ELIXIR : Ecrire des tests

### Doc Tests
Lorsqu'on documente son code Elixir, il est possible d'y ajouter des exemples.
Si ces exemples respectent la bonne mise en forme c'est derniers pourront être éxécutés en tant que test.

Exemple de mise en forme à respecter :

    @doc """
      Determines whether a deck contain a given card.

    ## Examples

        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Spades")
        true

    """
    
En effet, si cette mise en forme est respectée pour l'ensemble des exemples inscrits dans la documentation des fonctions seront exécutés et vérifiés, lorsque la commande `mix test` sera lancée.

    λ mix test
    Compiling 1 file (.ex)
    warning: variable "deck" is unused
      (for doctest at) lib/cards.ex:46

    ..

    Finished in 0.04 seconds
    2 tests, 0 failures

    Randomized with seed 882000
    
### Case Tests
Pour ajouter de nouveaux cas de tests, il est nécessaire d'éditer le fichier `nom_du_projet_test.exs`, présent dans le répertoire  `test`.

Ci-dessous quelques exemples de Case Test :
    
    test "create_deck makes 20 cards" do
      deck_length = length(Cards.create_deck)
      # Keyword `assert` is very important
      # Literraly, assert means `make sure that`
      assert deck_length == 20
    end
    
    test "shuffling a deck randomizes it" do
      deck = Cards.create_deck
      # The keyword `assert` could be replace by the keyword `refute`
      # assert deck != Cards.shuffle(deck)
      refute deck == Cards.shuffle(deck)
    end
    
> Attention : 
le mot clé `assert` est trés important. 
Littéralement, on pourrait le traduire par "Sois sûr que".
Comme nous le montre le deuxième Case Test ci-dessus, il est également possible d'utiliser le mot clé `refute`, opposé au mot clé `assert`.
