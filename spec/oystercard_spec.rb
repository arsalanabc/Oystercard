require 'Oystercard' 

describe Oystercard do
	let(:entry_station) { double :station}
	let(:exit_station) { double :station}
	let(:journey) { double :journey }
	let(:journey_class) { double :journey_class }
	let(:d_journeylog_class) { double :Journeylog_class }
	let(:d_journeylog) { double :journeylog }



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

	end


	describe '#touch_out' do
		it 'records the end of the journey' do
			allow(journey).to receive(:end)
			allow(journey).to receive(:complete?).and_return(true)
			allow(journey).to receive(:fare).and_return(1)
			os = Oystercard.new
			

			os.topup(2)
			os.touch_in(entry_station)
			expect{ os.touch_out(exit_station) }.to change{ os.balance }.by(-1)

			expect(journey.complete?).to eq true
		end

		it 'removes entry_station' do
			subject.topup(2)
			subject.touch_in(entry_station)
			subject.touch_out(nil)
			expect(subject.entry_station).to eq nil
		end
	end

	context 'adding journeylog to oystercard' do
		o_card = nil
		before 'initialize' do
			allow(d_journeylog_class).to receive(:new).and_return(d_journeylog)
			allow(d_journeylog).to receive(:start).with(entry_station)
			allow(d_journeylog).to receive(:finish).with(exit_station)
			allow(d_journeylog).to receive(:log).with(exit_station)

		allow(d_journeylog).to receive(:fare).and_return(Journey::MIN_FARE)

			
			o_card = Oystercard.new(d_journeylog)
			o_card.topup(30)
		end

		it 'adds journeylog' do			
			expect(o_card.journeylog).to eq d_journeylog
		end

		it 'starts a journey with journeylog' do
			
			
			expect(d_journeylog).to receive(:start)

			o_card.touch_in(entry_station)


		end

		it 'ends a journey with journeylog' do

			
			o_card.touch_in(entry_station)
			
			expect(d_journeylog).to receive(:finish)

			o_card.touch_out(exit_station)


		end
	end



end



















