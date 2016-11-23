module Rocker
	@rocker_rx, @rocker_ry = 0
	@rocker_rg = false
	@rocker_iface = []
	@@rocker_num = 1

	def rocker_set_pins(opt={})
		@rocker_rx = opt[:rx] if opt[:rx]
		@rocker_ry = opt[:ry] if opt[:ry]
		@rocker_rg = opt[:rg] if opt[:rg]
		@rocker_iface = [@rocker_rx, @rocker_ry, @rocker_rg]
		@rocker_iface
	end
#\
# The rocker_set_pins Store : {Interface => [pin, val, tag, desc]
#
	def rocker_set_rx(pin)
		recv = self.reg_analog(pin,nil,"rocker_rx##{@@rocker_num}")
		rocker_set_pins(:rx => recv)
	end

	def rocker_set_ry pin
		recv = self.reg_analog(pin,nil,"rocker_ry##{@@rocker_num}")
		rocker_set_pins(:ry => recv)
	end

	def rocker_set_rg pin
		recv = self.reg_digital(pin,nil,"rocker_rg##{@@rocker_num}")
		rocker_set_pins(:rg => recv)
	end

	#
	# The x and y must be analog
	# The g must be digital
	#
	def rocker_set_all x,y,g
		rocker_set_rx x
		rocker_set_ry y
		rocker_set_rg g
		@rocker_iface
	end
	
	def rocker_read_rx
		self.analog_read(@rocker_iface[0][0])
	end

	def rocker_read_ry
		self.analog_read(@rocker_iface[1][0])
	end

	def rocker_read_rg
		self.digital_read(@rocker_iface[2][0])
	end

	def rocker_read_all
		rx = rocker_read_rx
		ry = rocker_read_ry
		rg = rocker_read_rg
		printf("X:%10s Y:%10s G:%10s\n",rx,ry,rg)
	end
end
