class Journeylog

	attr_reader :log, :journey_class

	def initialize(journey_class = Journey)
		@log = []
		@journey_class = journey_class
	end

	def start(station)
		
		j = @journey_class.new
		j.start(station)
		@log << j
	
	end

	def finish(ext_station)
		temp = current_journey?
		temp.end(ext_station)
		@log << temp
	end

	def journeys
		@log
	end
	private

	def current_journey?
		return @log.last if @log.last.complete?
		new_journey = @journey.new



	end
end      
