require 'Journey'

describe Journey do
	let(:ent_station) {double :station}
	let(:ext_station) {double :station}
	it 'starting station' do
		j = Journey.new
		j.start(ent_station)
		
		expect(j.start_station).to eq ent_station
	end
	it 'ending station' do
		j = Journey.new()
		j.end(ext_station)
		expect(j.exit_station).to eq ext_station
	end
	describe '#complete?' do
		it 'journey_complete at default' do
			expect(subject).to_not be_complete
		end
		it 'journey complete at touch_in' do
			j = Journey.new
			j.start(ent_station)
			expect(j).to_not be_complete
		end

		it 'journey complete at touch_out' do
			j = Journey.new
			j.end(ext_station)
			expect(j).to_not be_complete
		end

		it 'journey complete at touch_in and touh out' do
			j = Journey.new
			j.start(ent_station)
			j.end(ext_station)
			expect(j).to be_complete
		end
	end

	describe '#fare' do
		it 'charges min fare at complete' do
			subject = Journey.new
			subject.start(ent_station)
			subject.end(ext_station)
			expect(subject.fare).to eq Journey::MIN_FARE
		end
		it 'charges penalty fare at incomplete' do
			j1 = Journey.new
			j1.start(ent_station)
			expect(j1.fare).to eq Journey::PENALTY_FARE

			j2 = Journey.new
			j2.end(ext_station)
			expect(j2.fare).to eq Journey::PENALTY_FARE
		end
	end
end
