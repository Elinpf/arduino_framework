module Module_

#
# 摇杆有5个接口，GND/+5V/RX/RY/SW
# RX/RY 都接在Analog上 SW是有0 1 接在Digital上
#
class Rocker < Module
	def rocker_setup x,y,sw
		reg_analog_pin get_id(x), x, module_name
		reg_analog_pin get_id(y), y, module_name
		reg_digital_pin get_id(sw), sw, Interface::Input,module_name
		self.get_store
	end

	def module_name
		"Rocker"
	end
end	#class
end	#module
