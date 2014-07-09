require 'docking_station'

describe DockingStation do
	context 'that is empty' do
		let(:docking_station) { DockingStation.new }
		it 'is not full' do
			expect(docking_station).not_to be_full
		end

		it 'should know the bike count' do
			expect(docking_station.bike_count).to eq 0
		end

		it 'can dock bikes' do
			bike = double :bike
			docking_station.dock bike
			expect(docking_station.bike_count).to eq 1
		end
	end

	context 'that is full' do
		it 'should be full' do
			docking_station = DockingStation.new
			DockingStation::DEFAULT_CAPACITY.times { docking_station.dock(:bike) }
			expect(docking_station).to be_full
		end

		it 'can release a bike' do
			docking_station = DockingStation.new
			DockingStation::DEFAULT_CAPACITY.times { docking_station.dock(:bike) }
			expect(docking_station.release_bike).to eq :bike
		end
	end

	context 'that has mixture of broken and working bikes' do
		
		it 'should know that bikes are working' do
			docking_station = DockingStation.new
			working_bike = double :bike, broken?: false
			broken_bike = double :bike, broken?: true
			docking_station.dock working_bike
			docking_station.dock broken_bike

			expect(working_bike).to receive(:broken?)
			docking_station.available_bikes
		end

		it 'should return only available bikes' do
			docking_station = DockingStation.new
			working_bike = double :bike, broken?: false
			broken_bike = double :bike, broken?: true
			docking_station.dock working_bike
			docking_station.dock broken_bike

			expect(working_bike).to receive(:broken?).and_return(false)
			
			expect(docking_station.available_bikes).to eq [working_bike]
		end
	end
end