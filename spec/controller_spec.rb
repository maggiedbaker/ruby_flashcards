require_relative '../controller'
require_relative '../parser'
require_relative '../view'
require_relative '../deck'
require_relative '../card'

class View
  def set_fake_input(fake_input)
    @fake_input = fake_input
  end

  def get_input
    @fake_input.shift
  end

  def messages
    MESSAGES
  end
end

class Controller
  attr_reader :view
end

describe "Controller" do
  let(:messages) { View.new.messages }
  let(:deck_file) { "test_deck.txt" }
  let(:empty_deck_file) { "empty_deck.txt" }
  let(:controller) { Controller.new(deck_file) }
  let(:controller_empty_deck) { Controller.new(empty_deck_file) }

  describe "run"
    it 'should say hello when you start' end
       expect{controller.run}.to output(messages[:hello]+"\n").to_stdout
    end

    it 'should quit when you pass an empty deck' end
       expect{controller_empty_deck.run}.to output(messages[:hello]+"\n"+messages[:goodbye]+"\n").to_stdout
    end

    it 'should quit when you type quit' end
       controller.view.set_fake_input = ["quit"]
       expect{controller.run}.to output(/#{messages[:goodbye]+"\n"}$/).to_stdout
    end
end
