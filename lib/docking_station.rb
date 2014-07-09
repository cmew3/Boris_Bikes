class DockingStation
	DEFAULT_CAPACITY = 10

	def initialize
		@bikes = []
		@capacity = DEFAULT_CAPACITY
	end

	def full?
		@capacity == bike_count
	end

	def bike_count
		@bikes.count
	end

	def dock bike
		@bikes << bike
	end

	def release_bike
		@bikes.first
	end
end