require 'Journeylog'
describe Journeylog do 
	let (:d_journey_class) {double :Journey_class}
	let (:d_journey) {double :Journey}
	let (:d_start_station) {double :station}
	let (:d_exit_station) {double :station}
	let (:d_card) {double :Oystercard}

	
	
	

	it 'holds a journey' do
		allow(d_journey_class).to receive(:new).and_return(d_journey)
		jl = Journeylog.new(d_journey_class)
		expect(jl.log) == []
	end

	it '#start' do
		allow(d_journey_class).to receive(:new).and_return(d_journey)
		allow(d_journey).to receive(:start).and_return(nil)
		allow(d_journey).to receive(:start_station).and_return(d_start_station)
		
		jl = Journeylog.new(d_journey_class)
		jl.start(d_start_station)
		expect(jl.log.last.start_station).to eq d_start_station
		
		expect(jl.log.last).to eq d_journey
	end


end