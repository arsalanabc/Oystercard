require 'Journey'

describe Journey do
	let(:ent_station) {double :station}
	let(:ext_station) {double :station}
	it 'starting station' do
		subject.start(ent_station)
		expect(subject.start_station).to eq ent_station
	end
	it 'ending station' do
		subject.end(ext_station)
		expect(subject.exit_station).to eq ext_station
	end
	describe '#complete?'
		it 'journey_complete at default' do
			expect(subject).to_not be_complete
		end
		it 'journey complete at touch_in' do
			subject.start(ent_station)
			expect(subject).to_not be_complete
		end

		it 'journey complete at touch_out' do
			subject.end(ext_station)
			expect(subject).to_not be_complete
		end

		it 'journey complete at touch_in and touh out' do
			subject.start(ent_station)
			subject.end(ext_station)
			expect(subject).to be_complete
		end
end