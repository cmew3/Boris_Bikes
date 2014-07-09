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
end