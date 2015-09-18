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

end
