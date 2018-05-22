class Journey
	attr_reader :start_station, :exit_station

	def start(station)
		@start_station = station
	end

	def end(station)
		@exit_station = station
	end

	def complete?
		@start_station && @exit_station
	end
end