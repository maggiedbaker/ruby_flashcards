class Card

  attr_reader :definition, :term

  def initialize(args = {})
    @definition = args[:definition]
    @term = args[:term]
  end


  def to_s
    "#{@term}: #{@definition}"
  end

end

