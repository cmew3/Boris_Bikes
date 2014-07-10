require_relative 'bike_container'

class DockingStation
	include BikeContainer

	DEFAULT_CAPACITY = 10
	attr_reader :capacity

	# def initialize(options = {})
	# 	raise "Capacity is not an integer" if invalid? options
	# 	@capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
	# end

	def release_first_available_bike
		raise "There are no available bikes!!" unless has_available_bike?
		available_bikes.first
	end

end