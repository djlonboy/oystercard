require 'oystercard'
require 'station'

describe Oystercard do

  let(:station) {double :station}

  describe "during set up" do

    it { is_expected.to be_instance_of(Oystercard) }

    it "should have a balance of zero as a new card" do
      expect(subject.balance).to eq 0
    end

    it "should have a default in journey status of false" do
      expect(subject.in_journey?).to eq false
    end

  end

  describe "when topping up" do

    it "should allow the user to top up the card" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "will produce an error if top up goes over max value" do
      max_balance = Oystercard::MAX_BALANCE
      expect { subject.top_up(max_balance + 0.01) }.to raise_error("max balance £#{max_balance} exceeded")
    end

  end

  describe "when touching in" do

    it "can change journey status" do
      subject.balance = Oystercard::MIN_BALANCE
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end

    it "will not let user touch in with balance below minimum" do
      subject.balance = Oystercard::MIN_BALANCE - 0.01
      expect { subject.touch_in(station) }.to raise_error("Insufficient funds")
    end

    it "will store the station name on touch in" do
      subject.balance = Oystercard::MIN_BALANCE
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

  end

  describe "when touching out" do

    it "can change journey status" do
      subject.entry_station = station
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end

    it "will reduce balance by minimum fare" do
      subject.balance = Oystercard::MIN_BALANCE
      subject.entry_station = station
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MIN_BALANCE)
    end

    it "will forget the entry station" do
      subject.entry_station = station
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end

    it "will store the exit station" do
      subject.touch_out(station)
      expect(subject.exit_station).to eq station
    end

  end

  describe "during journey" do

    it "returns the correct journey status" do
      subject.entry_station = station
      expect(subject.in_journey?).to eq true
    end

  end
end

# Don't need to test private methods
  # it "will deduct the cost of my fare" do
  #   subject.top_up(10)
  #   subject.deduct(5)
  #   expect(subject.balance).to eq(5)
  # end
