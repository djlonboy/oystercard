class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_accessor :balance, :journey_status, :entry_station

  def initialize
    @balance = 0
    @journey_status = false
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MIN_BALANCE
    @entry_station = station
    @journey_status = true
  end

  def touch_out
    @journey_status = false
    deduct(MIN_BALANCE)
  end

  def in_journey?
    @journey_status
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
