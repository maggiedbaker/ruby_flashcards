class Controller

  def initialize(filename)
    @view = View.new
    @deck = Deck.new(Parser.import(filename))
  end

  def run
    input = ""
    view.clear_screen
    view.display_message(:hello)
    until input == "quit" || deck.completed
      input = ask_next_card(deck)
    end
    view.display_message(:goodbye)
  end

  private

  def ask_next_card(deck)
    input = ""
    current_card = deck.get_card
    correct = false
    until correct || ["quit","skip","give up"].include?(input)
      view.display_definition(current_card)
      view.display_prompt
      input = view.get_input.downcase
      view.clear_screen
      if input == current_card.term.downcase
        view.display_message(:right)
        correct = true
      elsif input == "give up"
        view.display_message(:give_up)
        view.display_term(current_card)
        view.display_message(:skip)
      elsif input == "skip"
        view.display_message(:skip)
      elsif input == "quit"
        # intentionally do nothing
      else
        view.display_message(:wrong)
      end
    end
    input
  end

  attr_reader :view, :deck
end
