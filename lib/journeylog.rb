class Journeylog

	attr_reader :log, :journey_class

	def initialize(journey_class = Journey)
		@log = []
		@journey_class = journey_class
	end

	def start(station)
		
		j = @journey_class.new
		j.start(station)
		@log.push(j)
	
	end

	private

	def current_journey?
		return @log.last if @log.last.complete?
		new_journey = @journey.new



	end
end      

 require './lib/Journey'
 require './lib/Station'
# t = Journeylog.new(Journey)
# s = Station.new("bank", 1)
# # t.start(s)