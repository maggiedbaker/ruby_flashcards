require_relative 'stat'
require_relative 'controller'
require_relative 'deck'
require_relative 'card'
require_relative 'parser'
require_relative 'view'


if ARGV.first != nil
  if ARGV.first.include? ".txt"
    Controller.new(ARGV.first).run
  else
    puts "Please supply a .txt file."
  end
else
  Controller.new("flashcards.txt").run
end