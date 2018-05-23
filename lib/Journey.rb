class Journey
	MIN_FARE = 1
	PENALTY_FARE = 6
	attr_reader :start_station, :exit_station

	def initialize(station = nil)
		@start_station = station
		@exit_station = nil
		
	end

	

	def end(station)
		@exit_station = station
	end

	def complete?
		@start_station && @exit_station
	end


	def fare
		return MIN_FARE if complete?
		PENALTY_FARE
	end 
end