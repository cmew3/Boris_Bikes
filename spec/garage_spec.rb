require 'garage'
require 'bike_container_spec'
describe Garage do

	it_behaves_like 'A bike container'

	let(:garage) { Garage.new }
	it 'can have a default capacity' do
		expect(garage.capacity).to eq Garage::GARAGE_DEFAULT_CAPACITY
	end

	it 'fix broken bike when docked in garage' do
		broken_bike = double :bike
		expect(broken_bike).to receive(:fix!)
		garage.fix_bike broken_bike
	end
end