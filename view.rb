class View

  MESSAGES = {
    hello: <<-HELLO,
Hello, welcome to Ruby Flashcards!

You are able to type 'quit' to stop at anytime.
Type 'skip' to skip the current card.
Type 'give up' to see the answer.
Enter the number for the game you would like to play:

1. Classic flashcards
2. Multiple choice flashcards
    HELLO
    start: "\nGreat! Let's begin!",
    goodbye: "\nThanks for playing! Winners don't do drugs.",
    right: "Correct! Good job!",
    wrong: "Please try again.",
    skip: "Okay. Moving on...",
    give_up: "Here is the answer: ",
    off_by_one: "Close enough! The answer was:",
    recap: "\nOkay, here's a recap:"
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
      unless records[response].nil?
        puts "\nYou chose #{response} on #{records[response].size}: "
        puts "\n#{records[response].join("\n\n")}" 
      end
    end
    puts
  end

  def display_incorrect(records)
    unless records.select { |k,v| k.class == Card }.empty?
      puts "Here are the ones with the most incorrect guesses:\n\n"
      records.select { |k,v| k.class == Card }.sort_by { |k,v| -v.size }.each do |card|
        puts card[0]
        puts "Number of attempts: #{card[1].size}. Guesses: #{card[1].join(", ")}"
        puts
      end
      puts "Would you like to retry this subset? Enter 'no' to exit the program."
      puts
    end
  end

end

