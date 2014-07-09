require 'docking_station'

describe DockingStation do
	let(:docking_station) { DockingStation.new }
	context 'capacities' do
		it 'can be any number' do
			station = DockingStation.new(capacity: 25)
			expect(station.capacity).to eq 25
		end

		it 'can have a default capacity' do
			expect(docking_station.capacity).to eq 10
		end

		it 'cannot be invalid' do
			expect(docking_station.invalid? capacity: "A").to be true	
		end

		it 'cannot be a non integer value' do
			expect { DockingStation.new(capacity: "A") }.to raise_error(RuntimeError)
		end
	end

	context 'that is empty' do
		
		it 'is not full' do
			expect(docking_station).not_to be_full
		end

		it 'knows that it is empty' do
			expect(docking_station.bike_available?).to eq false 
		end

		it 'should know the bike count' do
			expect(docking_station.bike_count).to eq 0
		end

		it 'can dock bikes' do
			bike = double :bike
			docking_station.dock bike
			expect(docking_station.bike_count).to eq 1
		end

		it 'when docked should return nil' do
			bike = double :bike
			expect(docking_station.dock bike).to eq nil
		end

		it 'cannot release bike' do
			expect{ docking_station.release_bike }.to raise_error(RuntimeError)
		end
	end

	context 'that is full' do
		it 'should be full' do
			docking_station.capacity.times { docking_station.dock(:bike) }
			expect(docking_station).to be_full
		end

		it 'cannot dock anymore bikes' do
			docking_station.capacity.times { docking_station.dock(:bike) }
			expect{ docking_station.dock(:bike) }.to raise_error(RuntimeError)
		end
	end

	context 'that has mixture of broken and working bikes' do
		
		it 'should know that bikes are working' do
			working_bike = double :bike
			docking_station.dock working_bike

			expect(working_bike).to receive(:broken?)
			docking_station.available_bikes
		end

		it 'should return only available bikes' do
			working_bike = double :bike, broken?: false
			broken_bike = double :bike, broken?: true
			docking_station.dock working_bike
			docking_station.dock broken_bike
		
			expect(docking_station.available_bikes).to eq [working_bike]
		end

		# test the interaction
		# double check with someone to see if im doing it correctly?
		it 'should release bike' do
			working_bike = double :bike, broken?: false
			broken_bike = double :bike, broken?: true
			docking_station.dock broken_bike
			docking_station.dock working_bike
			expect(docking_station).to receive(:bike_available?).and_return([working_bike])
			expect(docking_station).to receive(:available_bikes).and_return([working_bike])
			docking_station.release_bike
		end
		# then test the data
		it 'should release the first available bike' do
			working_bike = double :bike, broken?: false
			broken_bike = double :bike, broken?: true
			docking_station.dock broken_bike
			docking_station.dock working_bike

			expect(docking_station.release_bike).to eq working_bike
		end
	end
end