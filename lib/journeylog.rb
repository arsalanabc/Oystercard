class Journeylog

	attr_reader :log, :journey_class, :fare

	def initialize(journey_class = Journey)
		@log = []
		@journey_class = journey_class

	end

	def start(station)
		
		journey = @journey_class.new
		journey.start(station)
		@log << journey
	
	end

	def finish(ext_station)
		temp = current_journey
		temp.end(ext_station)
		@log << temp
		@fare = temp.fare
	end

	def journeys
		@log.dup
	end
	private

	def current_journey
		return @log.last unless @log.last.complete?
		new_journey = @journey_class.new
	end
end      

require './lib/Journey'
require './lib/Station'

jl = Journeylog.new

jl.start("bank")
jl.finish("algate")
p jl.log
p jl.log.last.complete?

