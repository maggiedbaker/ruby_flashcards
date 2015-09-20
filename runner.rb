require_relative 'stat'
require_relative 'controller'
require_relative 'deck'
require_relative 'card'
require_relative 'parser'
require_relative 'view'


Controller.new("flashcards.txt").run
