defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  # Case Test
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
end
