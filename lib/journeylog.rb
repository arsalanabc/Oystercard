class Journeylog

	attr_reader :log, :journey

	def initialize(journey_class)
		@log = []
		@journey = journey_class.new
	end

	def start(station)
		@journey.start(station)
		log << @journey
	end

	private

	
end      

# require './lib/Journey'
# require './lib/Station'
# t = Journeylog.new(Journey.new)
# t.start(Station.new("bank", 1))