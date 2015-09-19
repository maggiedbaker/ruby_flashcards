require_relative '../parser'
require_relative '../deck'

describe Parser do

  let(:deck) { Deck.new(Parser.import("flashcards.txt")) }

  describe '#import' do
    it 'should import the entire contents of the text file as a deck of flashcards' do
      expect(deck.cards.shift.to_s).to eq("alias: To create a second name for the variable or method.")
      expect(deck.cards.pop.to_s).to eq("yield: Called from inside a method body, yields control to the code block (if any) supplied as part of the method call. If no code block has been supplied, calling yield raises an exception.")
    end
  end

end
