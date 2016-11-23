module Rocker
	@rocker_rx, @rocker_ry = 0
	@rocker_rg = false
	@rocker_iface = []
	@rocker_num = 1

	def rocker_set_pins(opt={})
		@rocker_rx = opt[:rx] if opt[:rx]
		@rocker_ry = opt[:ry] if opt[:ry]
		@rocker_rg = opt[:rg] if opt[:rg]
		return [@rocker_rx, @rocker_ry, @rocker_rg]
	end

	def rocker_set_rx(pin)
		recv = self.reg_analog(pin,nil,"rocker_rx##{@rocker_num}")
		rocker_set_pins(:rx => recv)
	end

	def rocker_set_ry pin
		recv = self.reg_analog(pin,nil,"rocker_ry##{@rocker_num}")
		rocker_set_pins(:ry => recv)
	end

	def rocker_set_rg pin
		recv = self.reg_digital(pin,nil,"rocker_rg##{@rocker_num}")
		rocker_set_pins(:rg => recv)
	end
	
	def rocker_get_rx
		@rocker_iface[0]	
