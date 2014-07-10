require 'bike_container'

shared_examples 'A bike container' do
	let(:holder) { described_class.new }

	context 'capacity' do
		it 'can be any number' do
			big_holder = described_class.new(capacity: 25)
			expect(big_holder.capacity).to eq 25
		end
		
		it 'knows if it is invalid' do
			expect(holder.invalid? capacity: "A").to be true	
		end

		it 'cannot be a non integer value' do
			expect { described_class.new(capacity: "A") }.to raise_error(RuntimeError)
		end
	end

	context 'that is empty' do
		
		it 'is not full' do
			expect(holder).not_to be_full
		end

		it 'knows that it is empty' do
			expect(holder).not_to have_available_bike 
		end

		it 'should know the bike count' do
			expect(holder.bike_count).to eq 0
		end

		it 'can dock bikes' do
			bike = double :bike
			holder.dock bike
			expect(holder.bike_count).to eq 1
		end

		it 'when docked should return nil' do
			bike = double :bike
			expect(holder.dock bike).to eq nil
		end

	end

	context 'that is full' do
		it 'should be full' do

			holder.capacity.times { holder.dock(double :bike) }
			expect(holder).to be_full
		end

		it 'cannot dock anymore bikes' do
			holder.capacity.times { holder.dock(double :bike) }
			expect{ holder.dock(:bike) }.to raise_error(RuntimeError)
		end
	end

	context 'that has mixture of broken and working bikes' do
		let(:working_bike) { double :bike, broken?: false }
		let(:broken_bike) { double :bike, broken?: true }
		
		it 'should know that bikes are working' do
			holder.dock working_bike

			expect(working_bike).to receive(:broken?)
			holder.available_bikes
		end

		it 'should return only available bikes' do
			holder.dock working_bike
			holder.dock broken_bike
		
			expect(holder.available_bikes).to eq [working_bike]
		end

		it 'should be able to return only broken bikes' do
			holder.dock working_bike
			holder.dock broken_bike

			expect(holder.broken_bikes). to eq [broken_bike]
		end

		it 'should release a single bike' do
			holder.dock working_bike
			holder.dock broken_bike
			holder.release broken_bike
			expect(holder.bikes).to eq [working_bike]
		end

		it 'should raise an error if bike is not present to be released' do
			holder.dock working_bike
			expect{holder.release(broken_bike)}.to raise_error RuntimeError
		end

		it 'cannot dock a bike twice' do
			holder.dock working_bike
			expect{ holder.dock working_bike }.to raise_error RuntimeError
		end
		
	end

end