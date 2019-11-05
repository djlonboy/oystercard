require 'oystercard'

describe Oystercard do
  it { is_expected.to be_instance_of(Oystercard) }

  it "should have a balance of zero as a new card" do
    oystercard = Oystercard.new
    expect(oystercard.balance).to eq 0
  end
end
