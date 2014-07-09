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
end