class Controller

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
    view.display_message(:start)
    if input == "2"
      @multiple_choice = true
    end
    until input == "quit" || deck.completed
      input = ask_next_card(deck)
    end
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
    until correct || ["quit","skip","give up"].include?(input)
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
      elsif off_by_one(input, current_card.term.downcase)
        view.display_message(:off_by_one)
        view.display_term(current_card)
        correct = true
        view.display_message(:skip)
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

  attr_reader :view, :deck, :multiple_choice
end
