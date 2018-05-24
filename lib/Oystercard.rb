class Oystercard 

	DEFAULT_BALANCE = 0
	MAXIMUM_BALANCE = 90
	FARE = 1

	attr_reader :balance, :entry_station, :journey_history, :local_journey

	def initialize
		@balance = DEFAULT_BALANCE
		@journey_history = []
		


	end

	def topup(amount)
		fail "Cannot top up: maximum balance of £#{MAXIMUM_BALANCE} reached" if maximum?(amount)
		@balance += amount
	end

	def touch_in(entry_station)
		 fail "Insufficient balance" unless sufficient_balance?
		 j = Journey.new
		 j.start(entry_station)
		journey_history << j

		 
	end

	def touch_out(exit_station)
		journey_history.last.end(exit_station)
		deduct(journey_history.last.fare)
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
