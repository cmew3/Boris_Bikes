require "bike"

describe Bike do
	let(:bike) { Bike.new }

	it 'should not be broken' do
		
		expect(bike).not_to be_broken
	end

	it 'can be broken' do
		bike.break!
		expect(bike).to be_broken
	end

	it 'can be fixed' do
		bike.break!
		bike.fix!
		expect(bike).not_to be_broken
	end
end