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

    it "should have an empty journey list" do
      expect(subject.journeys).to eq []
    end

    it "should have an empty last_journey hash" do
      expect(subject.last_journey).to eq({ entry: nil, exit: nil })
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
      expect(subject.last_journey[:entry]).to eq(station)
    end

  end

  describe "when touching out" do

    it "can change journey status" do
      subject.last_journey[:entry] = station
      subject.touch_out(station)
      expect(subject.in_journey?).to eq false
    end

    it "will reduce balance by minimum fare" do
      subject.balance = Oystercard::MIN_BALANCE
      subject.last_journey[:entry] = station
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MIN_BALANCE)
    end

    it "will store the exit station" do
      subject.touch_out(station)
      expect(subject.last_journey[:exit]).to eq station
    end

  end

  describe "during journey" do

    it "returns the correct journey status" do
      subject.last_journey[:entry] = station
      expect(subject.in_journey?).to eq true
    end

  end

  describe "after journey" do

    it "stores the entry and ext station in current_journey" do
      subject.balance = Oystercard::MIN_BALANCE
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.last_journey).to eq({ entry: station, exit: station })
    end

    it "should store the last journey in the list of all journeys" do
      subject.balance = Oystercard::MIN_BALANCE
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journeys).to include({ entry: station, exit: station })
    end

  end
end

# Don't need to test private methods
  # it "will deduct the cost of my fare" do
  #   subject.top_up(10)
  #   subject.deduct(5)
  #   expect(subject.balance).to eq(5)
  # end

# Test redundant after removing entry & exit station variables
  # it "will forget the entry station" do
  #   subject.last_journey[:entry] = station
  #   subject.touch_out(station)
  #   expect(subject.last_journey[:entry]).to eq nil
  # end
