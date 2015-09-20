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
  let(:cls) {"\e[H\e[2J"}
  let(:deck_file) { "spec/test_deck.txt" }
  let(:empty_deck_file) { "spec/empty_deck.txt" }
  let(:controller) { Controller.new(deck_file) }
  let(:controller_empty_deck) { Controller.new(empty_deck_file) }

  describe "run" do
    it 'should quit when you pass an empty deck' do
       expect{controller_empty_deck.run}.to output("#{cls}\n#{messages[:hello]}\n#{messages[:goodbye]}\n\n").to_stdout
    end

    it 'should quit when you type quit' do
       controller.view.fake_input = ["quit"]
       expect{controller.run}.to output(/#{messages[:goodbye]+"\n\n"}$/).to_stdout
    end
  end

  describe "#off_by_one" do
    it "should return true when words match or are off by one" do
      expect(controller.send(:off_by_one, "dog","doug")).to be true
      expect(controller.send(:off_by_one, "cat","cat")).to be true
      expect(controller.send(:off_by_one, "pizza","piza")).to be true
      expect(controller.send(:off_by_one, "orange","oranges")).to be true
      expect(controller.send(:off_by_one, "number","nunber")).to be true
      expect(controller.send(:off_by_one, "if","of")).to be true
      expect(controller.send(:off_by_one, "quiz","quid")).to be true
    end

    it "should return false when words are off by more than one" do 
      expect(controller.send(:off_by_one, "dog","god")).to be false
      expect(controller.send(:off_by_one, "mince","mints")).to be false
      expect(controller.send(:off_by_one, "soul","sole")).to be false
      expect(controller.send(:off_by_one, "spear","clear")).to be false
      expect(controller.send(:off_by_one, "taco","talon")).to be false
    end
  end

end
