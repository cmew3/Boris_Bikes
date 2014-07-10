require_relative 'bike_container'
class Van
	include BikeContainer
	attr_reader :capacity

	VAN_DEFAULT_CAPACITY = 25

	def initialize(options = {})
		raise "Capacity is not an integer" if invalid? options
		@capacity = options.fetch(:capacity, VAN_DEFAULT_CAPACITY)
	end

	def get_broken_bikes_from station
		station.broken_bikes.each do |bike| 
			self.dock bike
			station.release bike
		end
	end

	def drop_off_broken_bikes_to garage
		self.broken_bikes.each do |bike|
			garage.dock(bike)
			self.release bike
			garage.fix_bike(bike)
		end
	end

	def get_working_bikes_from garage
		garage.available_bikes.each do |bike|
			self.dock bike
			garage.release(bike)
		end
	end

	def drop_off_working_bikes_to station
		self.available_bikes.each do |bike|
			station.dock bike
			self.release bike
		end
	end
end