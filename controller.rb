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
    correct = false
    until correct || input == "quit" || input == "skip"
      view.display_definition(card)
      view.display_prompt
      input = view.get_input.downcase
      if input == current_card.term.downcase
        view.display_correct
        correct = true
      elsif input == "give up"
        view.display_give_up
        view.display_term(current_card)
      elsif input == "skip"
        view.display_skip
      elsif input == "quit"
        view.display_goodbye
      else
        display_wrong
      end
    end
    input
  end

  attr_reader :view, :deck
end
