require_relative '../controller'
require_relative '../parser'
require_relative '../view'
require_relative '../deck'
require_relative '../card'

class View
  def fake_input=(fake_input)
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
  let(:deck_file) { "spec/test_deck.txt" }
  let(:empty_deck_file) { "spec/empty_deck.txt" }
  let(:controller) { Controller.new(deck_file) }
  let(:controller_empty_deck) { Controller.new(empty_deck_file) }

  describe "run"
    it 'should quit when you pass an empty deck' do
       expect{controller_empty_deck.run}.to output(messages[:hello]+messages[:goodbye]+"\n").to_stdout
    end

    it 'should quit when you type quit' do
       controller.view.fake_input = ["quit"]
       expect{controller.run}.to output(/#{messages[:goodbye]+"\n"}$/).to_stdout
    end
end
