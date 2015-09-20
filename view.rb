class View

  MESSAGES = {
    hello: <<-HELLO,
Hello, welcome to Ruby Flash Cards!
You are able to type 'quit' to stop at anytime.
Type 'skip' to skip the current card.
Type 'give up' to see the answer.
Enter the number for the game you would 
like to play:
1. Classic flashcards
2. Multiple choice flashcards
    HELLO
    start: "\nGreat! Let's begin!",
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

  def display_choices(choices)
    puts
    # If you have an idea to make the choices look better on screen, go for it
    puts "\"#{choices[0]}\"\n\"#{choices[1]}\"\n\"#{choices[2]}\"\n\"#{choices[3]}\""
    puts
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  def display_results(records, responses)
    puts "Here are your results:\n"
    responses.each do |response|
      if !records[response].nil?
        puts "You chose #{response} on #{records[response].size}: "
        puts "\n#{records[response].join("\n\n")}" 
      end
      puts
    end
  end

  def display_incorrect(records)
    puts "Here are the ones with the most incorrect guesses:\n\n"
    records.select { |k,v| k.class == Card }.sort_by { |k,v| -v.size }.each do |card|
      puts card[0]
      puts "You guessed #{card[1].size} times: #{card[1].join(", ")}"
      puts
    end
    puts
  end

  def display_retry
    puts "Would you like to retry this subset?"
  end

end
