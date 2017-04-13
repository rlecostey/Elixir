defmodule Cards do
  # Add module documentation
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  # Add function documentation
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # Comprehension is like a map function
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do 
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contain a given card.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Devides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    # Erlang method to turn a list of string into a binary object
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do

    # OLD CODE
    # {status, binary} = File.read(filename)
    # case status do
    #   :ok -> :erlang.binary_to_term(binary)
    #   :error -> "That file does not exist."
    # end

    # NEW CODE : Reduce the code with pattern matching
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist."
    end  
  end

  def create_hand(hand_size) do
    # OLD CODE : without Pipe Operator
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    # NEW CODE : refactor the code with the Pipe Operator
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
