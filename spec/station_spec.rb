require 'station'

describe Station do
  it { is_expected.to be_instance_of Station}

  it "should have a zone" do
    station = Station.new(1)
    expect(subject.zone).to eq 1
  end






end
