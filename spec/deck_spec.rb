require_relative '../deck'
require_relative '../card'

describe Deck do
  array = [
    Card.new(term: "alias", definition: "To create a second name for the variable or method."),
    Card.new(term: "and", definition: "A command that appends two or more objects together."),
    Card.new(term: "BEGIN", definition: "Designates code that must be run unconditionally at the beginning of the program before any other.")
  ]

  let(:deck) { Deck.new(array) }
  let(:empty_deck) { Deck.new([]) }

  # describe '#get_card' do
  #   it 'should increment through the deck to return cards in order, and completed should be true after the last card. Then the deck should start back from the beginning, with completed returning false.' do
  #     expect(deck.completed).to be false
  #     expect(deck.get_card.to_s).to eq("alias: To create a second name for the variable or method.")
  #     expect(deck.get_card.to_s).to eq("and: A command that appends two or more objects together.")
  #     expect(deck.get_card.to_s).to eq("BEGIN: Designates code that must be run unconditionally at the beginning of the program before any other.")
  #     expect(deck.completed).to be true
  #     expect(deck.get_card.to_s).to eq("alias: To create a second name for the variable or method.")
  #     expect(deck.completed).to be false
  #   end

    describe '#get_card' do
    it 'should have completed equal true if initialized with an empty deck' do
      expect(empty_deck.completed).to be true
    end

    it 'should return a card object' do
      expect(deck.get_card).to be_a(Card)
    end

    it 'should increment through the deck to return cards in order, and completed should be true after the last card.' do
      expect(deck.completed).to be false
      expect(deck.get_card.to_s).to eq("alias: To create a second name for the variable or method.")
      expect(deck.get_card.to_s).to eq("and: A command that appends two or more objects together.")
      expect(deck.get_card.to_s).to eq("BEGIN: Designates code that must be run unconditionally at the beginning of the program before any other.")
      expect(deck.completed).to be true
    end

  end

end
