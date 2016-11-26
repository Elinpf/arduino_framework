# 这个模块是使用的装饰模式，采用method_missing查找被装饰者
# 其中实例变量@board 用来传递被装饰者句柄
# 以后开发的模块全部采用以下模式
# 示例：
# class Led
# 	include Decorador
#	def led
#		@board.interface
#	end
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
end
