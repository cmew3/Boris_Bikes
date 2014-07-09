require 'person'

describe Person do
	it 'should not have a bike' do
		person = Person.new
		expect(person).not_to have_bike
	end

	it 'can have bike' do
		bike = double :bike
		person = Person.new(bike)
		expect(person).to have_bike
	end

	it 'can break the bike' do
		bike = double :bike
		person = Person.new(bike)
		expect(bike).to receive(:break!)
		person.fall_down
	end

	it 'can rent a bike from docking station' do
		docking_station = double :station
		person = Person.new
		expect(docking_station).to receive(:release_bike)
		person.rent_bike_from docking_station
	end

	it 'receives bike after renting' do
		docking_station = double :station, release_bike: :bike
		person = Person.new
		person.rent_bike_from docking_station
		expect(person).to have_bike
	end

	it 'can return the bike to docking station' do
		docking_station = double :station
		person = Person.new(:bike)
		expect(docking_station).to receive(:dock).with(:bike)
		person.return_bike_to docking_station
	end

	it 'it has no bike when returning bike' do
		docking_station = double :station
		person = Person.new(:bike)
		expect(docking_station).to receive(:dock).with(:bike).and_return(nil)
		person.return_bike_to docking_station
		expect(person).not_to have_bike
	end
end