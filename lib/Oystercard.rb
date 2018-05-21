class Oystercard 

	DEFAULT_BALANCE = 0
	MAXIMUM_BALANCE = 90

	attr_reader :balance

	def initialize
		@balance = DEFAULT_BALANCE
	end

	def topup(amount)
		fail "Cannot top up: maximum balance of £#{MAXIMUM_BALANCE} reached" if maximum?(amount)
		@balance += amount
	end

	def deduct(amount)
		#fail "Cannot top up: maximum balance of £#{MAXIMUM_BALANCE} reached" if maximum?(amount)
		@balance -= amount
	end


	private

	def maximum?(amount)
		@balance + amount > MAXIMUM_BALANCE
	end

end
