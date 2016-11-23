#!/usr/lib/env ruby

class ArduinoFramework
	def initialize(ARGV)
		@board = ArduinoFirmata.connect ARGV.shift
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
	def reg_interface(intface, pin, val=nil, tag="", desc="")
		return unless @store.has_pin?(pin)
		if val == nil
			if interface == Interface::Analog
				@board.analog_read pin
			elsif interface == Interface::Digital
				@board.digital_read pin
			else
				return
			end
		else
			if interface == Interface::Analog
				@board.analog_write pin, val
			elsif interface == Interface::Digital
				@board.digital_write pin, val
			else
				return
			end
		end
		@store.insert(interface, pin, val, tag, desc)
	end

	def reg_digital(pin, val=nil, tag="", desc="")
		reg_interface(Interface::Digital, pin, val, tag, desc)
	end

	def reg_analog(pin, val=nil, tag="", desc="")
		reg_interface(Interface::Analog, pin, val, tag, desc)
	end

	def reg_module(mod, opt={})
		return unless mod = nil
		begin
			self.extend(mod)
		rescue
			raise "Module #{mod} is inavaild"
		end
	end
end

