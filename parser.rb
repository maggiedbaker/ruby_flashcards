require_relative 'card.rb'

module Parser

def self.import(file)

  filename = File.new(file)
  definitions = []
  terms = []
  filename.readlines.each_with_index do |line, i|
    if i % 3 == 0
      definitions << line
    elsif i % 3 == 1
      terms << line
    end
  end
  deck_array = []
  definitions.each_with_index do |definition, i|
    deck_array << Card.new(term: terms[i][0..-2], definition: definition[0..-2])
  end
deck_array
end

end
