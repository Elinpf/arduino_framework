#!/usr/lib/env ruby
require "observer"

class ArduinoFramework
	attr_reader :store, :framework
	include Observable

	def initialize
		@firmata = ArduinoFirmata.connect 
		@store = Store.new
		add_observer(@store)
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
				@firmata.pin_mode(pin, mode)
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
		return false if mod.empty?
		return false if Module_.const_defined? mod.to_sym
		(Module_.const_get mod.to_sym).new(self)
	end

	def analog_data
		data = Array.new(16, 0)
		16.times do |pin|
			data[pin] = @firmata.analog_read pin
		end
		data
	end

	def digital_input_data
		data = Array.new(16,0)
		16.times do |pin|
			data[pin] = @firmata.digital_read pin
		end
		data
	end

	#
	# 将Digital 和 Analog 的数据以观察者模式发送出去
	# 观察者一定要用update 方法接收
	#
	def start
		@notify = Thread.new do 
			loop do
				changed
				notify_observers(digital_input_data,
					analog_data)
				sleep 0.1
			end
		end
	end

	def stop
		@notify.stop
	end
end	#class

