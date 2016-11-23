#!/usr/bin/en ruby

require "arduino_firmata"


Pin_x, Pin_y = 0, 1
Pin_g = 7


module Rocker 
		@rx, @ry = 0
		@rg = false

	def get_x
		@rx = self.analog_read(Pin_x)
	end

	def get_y
		@ry = self.analog_read(Pin_y)
	end

	def get_g
		@rg = case self.digital_read(Pin_g)
			when 0 then false
			when 1 then true
			else
				self.digital_read(Pin_g)
			end
	end

	def get_all
		reslut = []
		reslut << self.get_x
		reslut << self.get_y
		reslut << self.get_g
		p reslut
	end
end

rock = ArduinoFirmata.connect
rock.extend(Rocker)

loop do
	rock.get_all
end
		
