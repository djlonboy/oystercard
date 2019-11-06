require 'station'

describe Station do

  subject(:station) {described_class.new("default", 0)}

  it "should create an instance of the station class" do
    expect(subject).to be_instance_of Station
  end

  it "should have a zone" do
    expect(subject.zone).to eq 0
  end

  it "should have a name" do
    expect(subject.name).to eq "default"
  end

end
