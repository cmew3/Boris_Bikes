class DockingStation
	attr_reader :capacity

	DEFAULT_CAPACITY = 10

	def initialize(options = {})
		raise "Capacity is not an integer" if not_valid options
		@bikes = []
		@capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
	end

	def not_valid options
		!options[:capacity].nil? && !options[:capacity].is_a?(Integer)
	end

	def full?
		@capacity == bike_count
	end

	def empty?
		@bikes.empty?
	end

	def bike_count
		@bikes.count
	end

	def dock bike
		raise "Station is full!!" if full?
		@bikes << bike
		nil
	end

	def release_bike
		raise "There are no bikes!!" if empty?
		available_bikes.first
	end

	def available_bikes
		@bikes.reject { |bike| bike.broken? }
	end
end