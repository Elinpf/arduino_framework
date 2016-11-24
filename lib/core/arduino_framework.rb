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
		if @store.has_pin?(iface, pin)
			return "The pin:#{pin} was registed"
		end
		if iface == Interface::Digital
			self.digital pin, val
		elsif iface == Interface::Analog
			self.analog pin, val
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

	def analog pin, val=nil
		if val == nil
			@board.analog_read pin
		else
			@board.analog_write pin, val
		end
	end

	def analog_read pin
		self.analog pin
	end

	def analog_write pin, val
		raise "val is Null" if val.nil?
		self.analog pin, val
	end

	def digital pin, val=nil
		if val == nil
			@board.digital_read pin
		else
			@board.digital_write pin,val
		end
	end

	def digital_read pin
		self.digital pin
	end

	def digital_write pin, val
		raise "val is Null" if val.nil?
	end
end

