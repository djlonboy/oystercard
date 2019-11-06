class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_accessor :balance, :journey_status, :entry_station

  def initialize
    @balance = 0
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out
    @entry_station = nil
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
