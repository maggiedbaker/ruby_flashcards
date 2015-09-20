# require_relative 'stat'

class Controller

  require 'pry'

  def initialize(filename)
    @view = View.new
    @deck = Deck.new(Parser.import(filename))
    @multiple_choice = false
  end

  def run
    input = ""
    view.clear_screen
    view.display_message(:hello)
    input = view.get_input
    view.display_message(:start) if input != 'quit'
    if input == "2" || input == "2."
      @multiple_choice = true
    end
    until input == "quit" || deck.completed
      input = ask_next_card(deck) 
    end
    retry_cards #examines wrong attempts    
    view.display_results(Stat.records, ["correctly", "skip","give up", "poor syntax"]) unless Stat.records.empty? # outputs guess conditionals except wrong attempts 
    view.display_message(:goodbye)
  end

  private

  def ask_next_card(deck)
    input = ""
    current_card = deck.get_card
    if multiple_choice == true
      # 'choices' contains three incorrect terms and the correct term, shuffled
      choices = ((deck.get_random_incorrect_terms(current_card.term)) << current_card.term).shuffle
    end
    correct = false
    until correct || ["quit","skip","give up"].include?(input) #
      view.display_definition(current_card)
      view.display_prompt
      if multiple_choice == true
        view.display_choices(choices)
      end
      input = view.get_input.downcase
      view.clear_screen
      if input == current_card.term.downcase
        view.display_message(:right)
        correct = true
        Stat.track("correctly",current_card) #records correctly and card
      elsif off_by_one(input, current_card.term.downcase)
        view.display_message(:off_by_one)
        view.display_term(current_card)
        correct = true
        view.display_message(:skip)
        Stat.track("poor syntax",current_card) #records poor syntax and card
      elsif input == "give up"
        view.display_message(:give_up)
        view.display_term(current_card)
        view.display_message(:skip)
        Stat.track(input,current_card) #records give up and card
      elsif input == "skip"
        view.display_message(:skip)
        Stat.track(input,current_card) #records skip and card 
      elsif input == "quit"
        # intentionally do nothing
      else
        view.display_message(:wrong)
        Stat.track(current_card, input) #records card and wrong input, calc attempts
      end
    end
    input
  end

  # check if a string is one character off from another string
  def off_by_one(guess, answer)
    string_a, string_b = [guess, answer].sort_by { |string| string.length }
    length_diff = string_b.length - string_a.length 
    # if length differs by one character, try removing each
    # character of the longer string one by one to see if any
    # versions match.
    if length_diff == 1
      string_b.length.times.any? do |index|
        string_b[0...index] + string_b[(index+1)..-1] == string_a
      end
    # if length is the same, compare letter by letter and
    # see if the number of differences is one or less
    elsif length_diff == 0
      string_a.length.times.count { |i| string_a[i] != string_b[i] } <= 1
    # if length difference is greater than one, the strings 
    # can't be off by one
    else
      false
    end
  end

  def retry_cards
    until Stat.records.select { |k,v| k.class == Card }.empty? # runs until no wrong guesses recorded
      view.display_results(Stat.records, ["correctly", "skip","give up", "poor syntax"]) #output previous results
      view.display_incorrect(Stat.records) # displays incorrect, asks if try again
      input = view.get_input 
      return view.display_message(:recap) if input == 'no' # only 'no' exits retry
      retry_deck = Deck.new(Stat.records.select { |k,v| k.class == Card }.keys) #create new deck of the multi guessed cards
      Stat.records = {} #reset stats to track new activity on smaller deck
      view.clear_screen
      until input == "quit" || retry_deck.completed
        input = ask_next_card(retry_deck)
      end    
    end
  end

  attr_reader :view, :deck, :multiple_choice

end
