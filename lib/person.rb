class Person
	def initialize(bike=nil)
		@bike = bike
	end

	def has_bike?
		!@bike.nil?
	end

	def fall_down
		@bike.break!
	end

	def rent_bike_from docking_station
		@bike = docking_station.release_bike
	end

	def return_bike_to docking_station
		@bike = docking_station.dock @bike
	end

end