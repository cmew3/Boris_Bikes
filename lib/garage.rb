require_relative 'bike_container'

class Garage
	GARAGE_DEFAULT_CAPACITY = 100
	attr_reader :capacity

	include BikeContainer
	def initialize(options = {})
		raise "Capacity is not an integer" if invalid? options
		@capacity = options.fetch(:capacity, GARAGE_DEFAULT_CAPACITY)
	end

	def fix_bike (bike)
		bike.fix!
	end
end