# require_relative 'stat'

class Controller

  require 'pry'

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
    view.display_results(Stat.records, ["correctly", "skip","give up"])
    view.display_incorrect(Stat.records)
    view.display_retry


    
    view.display_message(:goodbye)
  end

  private

  def ask_next_card(deck)
    input = ""
    current_card = deck.get_card  
    correct = false
    until correct || ["quit","skip","give up"].include?(input) #
      view.display_definition(current_card)
      view.display_prompt
      input = view.get_input.downcase 
      view.clear_screen
      if input == current_card.term.downcase
        view.display_message(:right)
        correct = true
        Stat.track("correctly",current_card) #records correctly guessed cards
      elsif input == "give up"
        view.display_message(:give_up)
        view.display_term(current_card)
        view.display_message(:skip)
        Stat.track(input,current_card) #records give up cards
      elsif input == "skip"
        view.display_message(:skip)
        Stat.track(input,current_card) #records skipped cards 
      elsif input == "quit"
        # intentionally do nothing
      else
        view.display_message(:wrong)
        Stat.track(current_card, input) #records card and wrong input, calc attempts
      end
    end
    input
  end



  attr_reader :view, :deck
end
