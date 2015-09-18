require_relative "../view"
require_relative "../card"



class View

  def messages
    MESSAGES
  end
end

describe "View" do
  let(:messages) { View.new.messages }
  let(:view) {View.new}
  let(:prompt) {"What term is this describing? "}
  let(:card) { Card.new({term: "rspec", definition: "testing"})}

  describe "#display_message" do
    it 'should print a message of respective symbol' do
      expect {view.display_message(:right)}.to output(messages[:right]+"\n").to_stdout
    end

    it 'should raise an error when message symbol not found' do
      expect {view.display_message(:none)}.to raise_error(ArgumentError)
    end
  end

  describe "#display_prompt" do
    it 'should print a nice prompt' do
      expect {view.display_prompt}.to output(prompt).to_stdout
    end
  end

  describe "#display_term" do
    it 'should print the card term' do
      expect {view.display_term(card)}.to output("rspec\n").to_stdout
    end
  end

  describe "#display_definition" do
    it 'should print the card definition' do
      expect {view.display_definition(card)}.to output("testing\n").to_stdout
    end
  end

end


