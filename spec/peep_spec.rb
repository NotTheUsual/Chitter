require_relative 'spec_helper'

describe Peep do
  let(:enrique) { double :Maker }
  let(:peep)    { Peep.new(message: "just setting up my chttr") }
  context "(upon initialization)" do
    it "should have text" do
      expect(peep.message).to eq("just setting up my chttr")
    end
  end
end