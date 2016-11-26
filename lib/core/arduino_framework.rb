#!/usr/lib/env ruby

class ArduinoFramework
	attr_reader :store
	def initialize
		@framework = ArduinoFirmata.connect 
		@store = Store.new
	end

	#
	# 注册只有两个用途
	#   1.初始化
	#   2.相关信息写入到Store中
	#
	# id		: 唯一标识，Store查询
	# interface	: Digital or Analog
	# pin 		: Number of the Interface
	# mode		: 这个mode只为Digital使用
	# desc		: Description
	#
	def reg_interface(id, iface, pin, mode=nil, desc="")
		# 这里要做修改，如果有，则更新。 如果没有，则添加
		if @store.has_id?(id)
			return "The Module:#{id} was registed"
		end
		if iface == Interface::Digital
			if mode.nil?
				@store.insert(id, iface, pin, mode, desc)
			else
				@framework.pin_mode(pin, mode)
				@store.insert(id, iface, pin, mode, desc)
			end
		elsif iface == Interface::Analog
			@store.insert(id, iface, pin, mode, desc)
		end
		@store
	end

	def reg_analog id, pin, desc
		reg_interface id, Interface::Analog, pin, nil, dsec 	
	end

	def reg_digital id, pin, mode=nil, desc
		reg_interface id, Interface::Digital, pin, mode, desc
	end

	#
	# 添加模块，暂时还没有想好
	#
	def add_module(mod)
		return if mod.empty?
	end

	def analog_read pin
		self.analog pin
	end

	def analog_write pin, val
		raise "val is Null" if val.nil?
		self.analog pin, val
	end


	def digital_read pin
		self.digital pin
	end

	def digital_write pin, val
		raise "val is Null" if val.nil?
	end
end

