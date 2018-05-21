require 'Oystercard' 

describe Oystercard do

	describe 'responds to methods' do
		it 'responds to the method balance' do
			expect(subject).to respond_to(:balance)
		end
	end

	describe '#balance' do 
		it 'contains default balance of 0' do
			expect(subject.balance).to eq 0
		end
	end


end