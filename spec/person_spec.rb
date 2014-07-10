require 'person'

describe Person do
	context 'with a bike' do
		let(:person) { Person.new(:bike) }
		let(:docking_station) { double :station}

		it 'has a bike' do
			expect(person).to have_bike
		end

		it 'can break the bike' do
			bike = double :bike
			person = Person.new(bike)
			expect(bike).to receive(:break!)
			person.fall_down
		end
		it 'can return the bike to docking station' do
			expect(docking_station).to receive(:dock).with(:bike)
			person.return_bike_to docking_station
		end

		it 'will have no bike after returning it' do
			expect(docking_station).to receive(:dock).with(:bike).and_return(nil)
			person.return_bike_to docking_station
			expect(person).not_to have_bike
		end

		it 'cannot rent a bike' do
			expect{ person.rent_bike_from docking_station }.to raise_error(RuntimeError)
		end
		
	end

	context 'without a bike' do
		let(:person) { person = Person.new }

		it 'should not have a bike' do
			expect(person).not_to have_bike
		end

		it 'can rent a bike from docking station' do
			docking_station = double :station
			expect(docking_station).to receive(:release_first_available_bike)
			person.rent_bike_from docking_station
		end

		it 'receives bike after renting' do
			docking_station = double :station, :release_first_available_bike: :bike
			person.rent_bike_from docking_station
			expect(person).to have_bike
		end

		it 'cannot return bike' do
			docking_station = double :station
			expect{ person.return_bike_to docking_station }.to raise_error(RuntimeError)
		end
		it 'cannot fall down' do
			docking_station = double :station
			expect { person.fall_down }.to raise_error(RuntimeError)
		end		
	end
end