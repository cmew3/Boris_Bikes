require_relative 'bike'

module BikeContainer
	DEFAULT_CAPACITY = 10

	def bikes
		@bikes ||= []
	end

	def capacity
		@capacity ||= DEFAULT_CAPACITY
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
		bikes.count
	end

	def dock bike
		raise "Station is full!!" if full?
		bikes << bike
		nil
	end


	def available_bikes
		bikes.reject { |bike| bike.broken? }
	end

	def broken_bikes
		bikes.select { |bike| bike.broken? }
	end
end