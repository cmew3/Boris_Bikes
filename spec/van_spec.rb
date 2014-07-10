require 'van'
require 'bike_container_spec'

describe Van do
	
	it_behaves_like 'A bike container'
	let(:van) { Van.new }
	let(:broken_bike) {double :bike, broken?: true}
	let(:working_bike) { double :bike, broken?: false }
	let(:actual_bike) { double :bike, instance: Bike}

	it 'removes the broken bikes from the station when it picks them up' do
		station = double :station, broken_bikes: [broken_bike]

		expect(station).to receive(:release).with(broken_bike)
		van.get_broken_bikes_from(station)
	end

	it 'has broken bikes when it picks up bikes from the station' do 
		station = double :station, broken_bikes: [broken_bike], release: :bike
		van.get_broken_bikes_from(station)

		expect(van.bike_count).to eq 1
	end

	it 'can drop off broken bikes to garage' do
		garage = double  :garage, fix_bike: :bike
		van.dock broken_bike

		expect(garage).to receive(:dock).with(broken_bike)
		van.drop_off_broken_bikes_to(garage)
	end

	it 'no longer has broken bikes when it has dropped them at garage' do
		garage = double :garage, dock: :bike, fix_bike: :bike
		van.dock(broken_bike)
		van.drop_off_broken_bikes_to(garage)
		
		expect(van.broken_bikes).to eq []
	end

	it 'requires the garage to fix broken bikes when they are dropped off' do
		garage = double :garage, dock: :bike
		van.dock broken_bike
		
		expect(garage).to receive(:fix_bike).with(broken_bike)
		van.drop_off_broken_bikes_to(garage)
	end

	it 'can pickup working bikes from garage' do
		garage = double :garage, available_bikes: [working_bike]
		
		expect(garage).to receive(:release).with(working_bike)
		van.get_working_bikes_from(garage)
	end
	
	it 'has working bikes when it picks them up from garage' do
		garage = double :garage, available_bikes: [working_bike], release: :bike
		van.get_working_bikes_from(garage)
		
		expect(van.available_bikes).to eq [working_bike]
	end

	it 'adds bikes to station when it drops it off to station' do
		station = double :station
		van.dock(working_bike)
		
		expect(station).to receive(:dock).with(working_bike)
		van.drop_off_working_bikes_to station
	end

		it 'no longer has working bikes when it drops it off to station' do
		station = double :station, dock: :bike
		van.dock(working_bike)
		van.drop_off_working_bikes_to(station)
		
		expect(van.bikes).to eq []
	end

	it 'station does not release a bike if van is full' do
		van = Van.new(capacity: 1)
		broken_bike_2 = double :bike, is_broken?: true
		van.dock broken_bike
		station = double :station, broken_bikes: [broken_bike_2]
		expect{ van.get_broken_bikes_from(station) }.to raise_error(RuntimeError) 
		expect(station).not_to receive(:release)
	end



end