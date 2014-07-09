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

	def bike_count
		@bikes.count
	end

	def dock bike
		@bikes << bike
		nil
	end

	def release_bike
		available_bikes.first
	end

	def available_bikes
		@bikes.reject { |bike| bike.broken? }
	end
end