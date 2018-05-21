class Oystercard 

	DEFAULT_BALANCE = 0
	MAXIMUM_BALANCE = 90
	FARE = 1

	attr_reader :balance, :entry_station

	def initialize
		@balance = DEFAULT_BALANCE
		@entry_station = nil
	end

	def topup(amount)
		fail "Cannot top up: maximum balance of £#{MAXIMUM_BALANCE} reached" if maximum?(amount)
		@balance += amount
	end

	def touch_in(entry_station)
		fail "Insufficient balance" unless sufficient_balance?
		@status = true
		@entry_station = entry_station
	end

	def in_journey?
		!@entry_station.nil?
	end

	def touch_out
		deduct(FARE)
		@status = false
		@entry_station = nil
	end

	private

	def deduct(amount)
		#fail "Cannot top up: maximum balance of £#{MAXIMUM_BALANCE} reached" if maximum?(amount)
		@balance -= amount
	end

	def maximum?(amount)
		@balance + amount > MAXIMUM_BALANCE
	end

	def sufficient_balance?
		@balance >= FARE 
	end

end
