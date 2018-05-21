class Oystercard 

	DEFAULT_BALANCE = 0
	MAXIMUM_BALANCE = 90

	attr_reader :balance, :status

	def initialize
		@balance = DEFAULT_BALANCE
		@status = "Touched out"
	end

	def topup(amount)
		fail "Cannot top up: maximum balance of £#{MAXIMUM_BALANCE} reached" if maximum?(amount)
		@balance += amount
	end

	def deduct(amount)
		#fail "Cannot top up: maximum balance of £#{MAXIMUM_BALANCE} reached" if maximum?(amount)
		@balance -= amount
	end

	def touch_in
		@status = "Touched in"
	end

	def in_journey?
		@status == "Touched in"
	end

	def touch_out
		@status = "Touched out"
	end

	private

	def maximum?(amount)
		@balance + amount > MAXIMUM_BALANCE
	end

end
