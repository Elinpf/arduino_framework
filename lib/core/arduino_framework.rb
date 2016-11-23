#!/usr/lib/env ruby

class ArduinoFramework
	def initialize
		@board = ArduinoFirmata.connect 
		@store = Store.new
	end

	#
	# Register the Interface PIN, and Store in Hash, 
	# Then erveryone can't use this PIN
	# interface	: Digital or Analog
	# pin 		: Number of the Interface
	# value		: The Pin value if not, is Read
	# tag		: I think if get this can know witch is about
	# desc		: Description
	#
	def reg_interface(iface, pin, val=nil, tag="", desc="")
		if not @store.has_pin?(iface, pin)
			return "The pin:#{pin} was registed"
		end
		if val == nil
			if iface == Interface::Analog
				@board.analog_read pin
			elsif iface == Interface::Digital
				@board.digital_read pin
			else
				return
			end
		else
			if iface == Interface::Analog
				@board.analog_write pin, val
			elsif iface == Interface::Digital
				@board.digital_write pin, val
			else
				return
			end
		end
		@store.insert(iface, pin, val, tag, desc)
	end

	def reg_digital(pin, val=nil, tag="", desc="")
		reg_interface(Interface::Digital, pin, val, tag, desc)
	end

	def reg_analog(pin, val=nil, tag="", desc="")
		reg_interface(Interface::Analog, pin, val, tag, desc)
	end

	def reg_module(mod, opt={})
		return if mod == nil
		begin
			self.extend(mod)
			$stdout.puts "import #{mod} Success"
		rescue
			raise "Module #{mod} is inavaild"
		end
	end
end

