require 'Station'
describe Station do
	it 'holds Station and zone name' do
		station = Station.new("station_1", 1)
		expect(station.name) == 'station_1'
		expect(station.zone) == 1
	end
	
	
end