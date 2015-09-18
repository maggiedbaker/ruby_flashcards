class View

  MESSAGES = {
    hello: <<-HELLO,
    Hello, welcome to Ruby Flash Cards!
    You are able to type 'quit' to stop at anytime.
    Type 'skip' to skip the current card.
    Type 'give up' to see the answer.
    HELLO
    goodbye: "Thanks for playing! Winners don't do drugs.",
    right: "Correct! Good job!",
    wrong: "Please try again.",
    skip: "Okay. Moving on...",
    give_up: "Here is the answer: "
  }

  def get_input
    gets.chomp
  end

  def display_prompt
    print "What term is this describing? "
  end

  def display_message(message_id)
    puts MESSAGES.fetch(message_id) {raise "Message not found"}
  end

  def display_definition(card)
    puts card.definition
  end

  def display_term(card)
    puts card.term
  end

end
