class Oystercard 

	DEFAULT_BALANCE = 0
	MAXIMUM_BALANCE = 90
	FARE = 1

	attr_reader :balance, :status

	def initialize
		@balance = DEFAULT_BALANCE
		@status = false
	end

	def topup(amount)
		fail "Cannot top up: maximum balance of £#{MAXIMUM_BALANCE} reached" if maximum?(amount)
		@balance += amount
	end

	def touch_in
		fail "Insufficient balance" unless sufficient_balance?
		@status = true
	end

	def in_journey?
		@status
	end

	def touch_out
		deduct(FARE)
		@status = false
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
