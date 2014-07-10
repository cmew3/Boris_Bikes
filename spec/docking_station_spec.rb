require 'docking_station'
require 'bike_container_spec'

describe DockingStation do
	let(:docking_station) { DockingStation.new }
	let(:working_bike) { double :bike, broken?: false }
	let(:broken_bike) { double :bike, broken?: true }

	it_behaves_like 'A bike container'

	it 'should release the first available bike' do
		docking_station.dock broken_bike
		docking_station.dock working_bike

		expect(docking_station.release_first_available_bike).to eq working_bike
	end
end