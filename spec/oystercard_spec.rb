require 'Oystercard' 

describe Oystercard do
	let(:entry_station) { double :station}
	let(:exit_station) { double :station}
	let(:journey) { double :journey }


	describe 'responds to methods' do
		it 'responds to the method balance' do
			expect(subject).to respond_to(:balance)
		end
		it 'responds to the topup balance' do
			expect(subject).to respond_to(:topup).with(1).argument
		end
		it 'responds to touching in' do
			expect(subject).to respond_to(:touch_in).with(1).argument
		end
		it 'responds to being on journey' do
			expect(subject).to respond_to(:in_journey?)
		end
		it 'responds to being touched out' do
			expect(subject).to respond_to(:touch_out).with(1).argument
		end
	end

	describe '#balance' do 
		it 'contains default balance of 0' do
			expect(subject.balance).to eq 0
		end
	end

	describe '#topup' do 
		it 'tops up balance' do
			value = 22
			expect{ subject.topup(value) }.to change{ subject.balance }.by(value)
		end

		it 'raises error when maximum balance is reached' do
			b = Oystercard.new
			b.topup(90)
			expect { b.topup(1) }.to raise_error "Cannot top up: maximum balance of £#{ Oystercard::MAXIMUM_BALANCE } reached"
		end
	end

	describe '#touch_in' do
		
		it 'raises Insufficient balance' do
			allow(journey).to receive(:complete?).and_return(false)
	
			expect{ subject.touch_in(journey) }.to raise_error "Insufficient balance"
		end

		it 'holds entry_station in journey' do
			allow(journey).to receive(:start_station).and_return(entry_station)
			subject.topup(2)
			subject.touch_in(entry_station)
			expect(subject.journey_history.last.start_station).to be entry_station 
		end
	end

	describe '#in_journey' do
		it 'records the journey' do
			subject.topup(1)
			subject.touch_in(entry_station)
			
			expect(subject.in_journey?).to eq true 
		end
	end

	describe '#touch_out' do
		it 'records the end of the journey' do
			allow(journey).to receive(:end)
			allow(journey).to receive(:complete?).and_return(false)

			subject.topup(2)
			subject.touch_in(entry_station)
			expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::FARE)

			expect(subject.in_journey?).to eq false
		end

		it 'removes entry_station' do
			subject.topup(2)
			subject.touch_in(entry_station)
			subject.touch_out(nil)
			expect(subject.entry_station).to eq nil
		end
	end

	describe 'list of journeys' do
		it 'lists entry and exit stations' do
			subject.topup(3)
			expect(subject.journey_history).to eq []
			subject.touch_in(entry_station)
			expect(subject.journey_history.last.start_station).to be entry_station 
			subject.touch_out(exit_station)
			expect(subject.journey_history.last.exit_station).to eq exit_station 
			subject.topup(3)
			subject.touch_in(entry_station)
			expect(subject.journey_history.last.start_station).to be entry_station 
			subject.touch_out(exit_station)
			expect(subject.journey_history.last.exit_station).to eq exit_station 
			subject.topup(3)
			subject.touch_in(entry_station)
			expect(subject.journey_history.last.start_station).to be entry_station 
			subject.touch_out(exit_station)
			expect(subject.journey_history.last.exit_station).to eq exit_station 
			subject.topup(3)
			subject.touch_in(entry_station)
			expect(subject.journey_history.last.start_station).to be entry_station 
			subject.touch_out(exit_station)
			expect(subject.journey_history.last.exit_station).to eq exit_station 
		end

	end


end