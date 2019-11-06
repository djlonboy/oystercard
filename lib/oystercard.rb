class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_accessor :balance, :journey_status, :entry_station
  attr_reader :exit_station, :journeys, :last_journey
  def initialize
    @balance = 0
    @journeys = []
    @last_journey = { entry: nil, exit: nil }
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    @entry_station = nil
    @exit_station = station
    deduct(MIN_BALANCE)
  end

  def in_journey?
    if entry_station != nil
      true
    else
      false
    end
  end

  def top_up(money)
    raise "max balance £#{MAX_BALANCE} exceeded" if check_if_maxed?(money)
    @balance += money
  end

  private

  def deduct(money)
    @balance -= money
  end

  def check_if_maxed?(amount)
    @balance + amount > MAX_BALANCE
  end

  end
