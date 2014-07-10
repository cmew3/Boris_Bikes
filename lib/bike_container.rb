module BikeContainer

	def bikes
		@bikes ||= []
	end

	def capacity
		@capacity 
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
		raise "Bike already here" if bikes.include? bike
		raise "Full!!! Cannot accept more bikes!" if full?
		bikes << bike
		nil
	end

	def release bike
		raise "Can't find that bike" unless bikes.include? bike
		bikes.delete(bike)
	end


	def available_bikes
		bikes.reject { |bike| bike.broken? }
	end

	def broken_bikes
		bikes.select { |bike| bike.broken? }
	end
end