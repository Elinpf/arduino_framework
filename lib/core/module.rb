# 这个模块是使用的装饰模式，采用method_missing查找被装饰者
# 其中实例变量@board 用来传递被装饰者句柄
# 以后开发的模块全部采用以下模式
# 示例：
# class Led
#       include Decorador
#       def led
#               @board.interface
#       end
# end

module Module_

module Decorator
	def initialize decorated
		@board = decorated
	end 

	def method_missing method, *args
		if args.empty? 
			@board.send method  
		else
			@board.send method, *args
		end 
	end
end


class Module
	include Decorator

	def reg_pin id, iface, pin, mode, desc 
		@board.reg_interface id, iface, pin, mode, desc
	end

	def reg_analog_pin id, pin, desc
		reg_pin id, Interface::Analog, pin, nil, desc
	end

	def reg_digital_pin id, pin, mode, desc
		reg_pin id, Interface::Digital, pin, mode, desc
	end

	def get_id pin
		self.module_name + "#" + pin.to_s
	end

	def set_desc desc
	end

	def get_pin id
	end

	def get_desc id
	end

	def get_store
		@board.store
	end

	def module_name
		"Unknow"
	end

end	#class
end	#module
