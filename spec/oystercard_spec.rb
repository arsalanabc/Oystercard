require 'Oystercard' 

describe Oystercard do

	describe 'responds to methods' do
		it 'responds to the method balance' do
			expect(subject).to respond_to(:balance)
		end
		it 'responds to the topup balance' do
			expect(subject).to respond_to(:topup).with(1).argument
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


end