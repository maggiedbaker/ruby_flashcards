require_relative "../view"

class View

  def messages
    MESSAGES
  end
end

describe "View" do
  let(:messages) { View.new.messages }
  let(:view) {View.new}

  describe "#display_message"
    it 'should print a message of respective symbol' do
      expect {view.display_message(:right)}.to output(messages[:right]+"\n").to_stdout
    end

    it 'should raise an error when message symbol not found' do
      expect {view.display_message(:none)}.to raise_error
    end

end


