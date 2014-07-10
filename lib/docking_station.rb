class DockingStation
	DEFAULT_CAPACITY = 10
	attr_reader :capacity

	def initialize(options = {})
		raise "Capacity is not an integer" if invalid? options
		@bikes = []
		@capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
	end

	def invalid? options
		!options[:capacity].nil? && !options[:capacity].is_a?(Integer)
	end

	def full?
		@capacity == bike_count
	end

	def has_available_bike?
		!available_bikes.empty?
	end

	def bike_count
		@bikes.count
	end

	def dock bike
		raise "Station is full!!" if full?
		@bikes << bike
		nil
	end

	def release_first_available_bike
		raise "There are no available bikes!!" unless has_available_bike?
		available_bikes.first
	end

	def available_bikes
		@bikes.reject { |bike| bike.broken? }
	end
end