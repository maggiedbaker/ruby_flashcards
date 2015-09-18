require_relative '../card'

describe Card do
  let(:card) { Card.new(term: "alias", definition: "To create a second name for the variable or method.") }

  describe '#to_s' do
    it 'should return the card as a string' do
      expect(card.to_s).to eq("alias: To create a second name for the variable or method.")
    end
  end

end
