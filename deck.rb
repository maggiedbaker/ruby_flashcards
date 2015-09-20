require_relative 'parser'

class Deck

  include Parser

  attr_reader :cards, :completed

  def initialize(cards = [])
    @cards = cards
    @working_deck = @cards.clone
    @cards.empty? ? @completed = true : @completed = false
  end

  def get_card
    # @completed = false
    # if @working_deck.empty?
      # @working_deck = @cards.clone
    # end
    if @working_deck.length == 1
      @completed = true
    end
    @working_deck.shift
  end

  # This method will return exactly three *incorrect* terms as an array.
  # (To do this, it compares randomly selected terms to the correct term.)
  def get_random_incorrect_terms(correct_term)
    four_random_cards = @cards.shuffle[0..3]
    three_random_incorrect_terms = four_random_cards.map {|card| card.term}.select {|term| term != correct_term}[0..2]
  end
end
