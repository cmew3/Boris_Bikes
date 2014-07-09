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
	end

	context 'that is full' do

		it 'should be full' do
			
		end
	end
end