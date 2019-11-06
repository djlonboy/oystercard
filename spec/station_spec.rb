require 'station'

describe Station do
  it "should create an instance of the station class" do
    station = Station.new(1)
    expect(station).to be_instance_of Station
  end

  it "should have a zone" do
    station = Station.new(1)
    expect(station.zone).to eq 1
  end

  it "should have a name" do
    station = Station.new("test", 1)
    expect(station.name).to eq "test"
  end






end
