require_relative 'spec_helper'

describe Peep do
  let(:enrique) { double :Maker }
  let(:time)    { Time.now }
  let(:peep)    { Peep.new(message: "just setting up my chttr", time: time) }
  let(:reply)   { Peep.new(message: "cool peep!", time: Time.now) }

  context "(upon initialization)" do
    it "should have text" do
      expect(peep.message).to eq("just setting up my chttr")
    end

    it "should have a short format time" do
      expect(peep.short_time).to eq(time.strftime "%b %-d")
    end

    it "should have a long format time" do
      expect(peep.long_time).to eq(time.strftime "%-l:%M %p - %-d %b %Y")
    end
  end

  it "should have a list of replies" do
    expect(peep.replies).to eq([])
  end

  it "should have a list of parents" do
    expect(peep.original).to eq(nil)
  end

  it "should be able to add a reply" do
    peep.replies << reply
    expect(peep.replies).to include(reply)
    expect(reply.original).to eq(peep)
  end
end