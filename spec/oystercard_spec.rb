require 'oystercard'

describe Oystercard do
  it { is_expected.to be_instance_of(Oystercard) }

  it "should have a balance of zero as a new card" do
    expect(subject.balance).to eq 0
  end

  it "should allow the user to top up the card" do
    subject.top_up(10)
    expect(subject.balance).to eq 10
  end

  it "will produce an arror if top up goes over max value" do
    max_balance = Oystercard::MAX_BALANCE
    expect { subject.top_up(max_balance + 0.01) }.to raise_error("max balance £#{max_balance} exceeded")
  end

end
