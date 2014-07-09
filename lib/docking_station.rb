class DockingStation
	def initialize
		@bikes = []
	end


	def full?
		false
	end

	def bike_count
		@bikes.count
	end

	def dock bike
		@bikes << bike
	end
end