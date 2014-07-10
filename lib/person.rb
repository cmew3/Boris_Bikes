class Person
	def initialize(bike=nil)
		@bike = bike
	end

	def has_bike?
		!@bike.nil?
	end

	def fall_down
		raise "You don't have a bike!!" unless has_bike?
		@bike.break!
	end

	def rent_bike_from docking_station
		raise "You already have a bike!!" if has_bike?
		@bike = docking_station.release_first_available_bike
	end

	def return_bike_to docking_station
		raise "You don't have a bike!!" unless has_bike?
		@bike = docking_station.dock @bike
	end

end