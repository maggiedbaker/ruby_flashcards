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
    give_up: "Here is the answer: ",
    off_by_one: "Close enough! The answer was:"
  }

  def get_input
    STDIN.gets.chomp
  end

  def display_prompt
    print "What term is this describing? "
  end

  def display_message(message_id)
    puts MESSAGES.fetch(message_id) {raise ArgumentError, "Message not found: #{message_id}"}
    puts
  end

  def display_definition(card)
    puts "\"#{card.definition}\""
    puts
  end

  def display_term(card)
    puts "\"#{card.term}\""
    puts
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

end
