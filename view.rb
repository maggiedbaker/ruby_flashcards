class View

  def get_input
    gets.chomp
  end

  def diplay_prompt
    print "What term is this describing? "
  end

  def diplay_message(arg)
    puts arg
  end

  def diplay_definition(card)
    puts card.definition
  end

  def diplay_term(card)
    puts card.term
  end

  def diplay_right
    puts "Correct! Good job!"
  end

  def diplay_wrong
    puts "Please try again."
  end

  def display_skip
    puts "Okay. Moving on..."
  end

  def display_give_up
    puts "Here is the answer: "
  end

  def diplay_hello
    puts "Hello, welcome to Ruby Flash Cards!"
    puts "You are able to type 'quit' to stop at anytime."
    puts "Type 'skip' to skip the current card."
    puts "Type 'give up' to see the answer."
  end

  def diplay_goodbye
    puts "Thanks for playing! Winners don't do drugs."
  end

end
