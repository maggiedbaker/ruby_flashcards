class Controller

  def initialize(filename)
    @view = View.new
    @deck = Parser.read(filename)
  end

  def run
    input = ""
    view.display_hello
    until input == "quit" || deck.empty?
      input = ask_next_card(deck)
    end
  end

  private

  def ask_next_card(deck)
    input = ""
    current_card = deck.get_card
    wrong_guesses = 0
    correct = false
    until wrong_guesses > 3 || correct || input == "quit"
      view.display_definition
      view.display_prompt
      input = view.get_input
      if input.downcase == current_card.term.downcase
        view.display_correct
        correct = true
      else
        view.display_wrong
        wrong_guesses += 1
      end
    end
    input
  end

  attr_reader :view, :deck
end
