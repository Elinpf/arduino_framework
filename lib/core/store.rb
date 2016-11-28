#!/usr/bin/env ruby

#
# This classes is use for Store the temp data
# And provid 
#
class Store < Hash
	def initialize 
		super
		@data = []
	end

	#
	# Only the Fixnum class
	# The pin is in 2/5
	#	
	def has_pin?(iface, pin)
		raise "Must input Fixnum" unless iface.kind_of? Fixnum and pin.kind_of? Fixnum
		return false if self.empty?
	# 找出interface 和 pin 都相等的
		self.each_with_index do |v,i|
			if i%5 == 1
				break if not v == iface
			end

			break if not i%5 == 2

			return true if v == pin
		end
		return false
	end

	def has_id? id
		self.has_key? id
	end

	#
	# Insert pin val and Description
	# {id => [iface, pin, val, desc]
	#
	def insert(id, iface, pin, mode, desc='')
		self[id] = [iface, pin, mode, desc]
	end
	
	def inspect
		super
		# 取注册了的接口
		# 取列中最长长度
		self.keys.sort do |k1, k2|
			k1.size <=> k2.size
		end
		
	end

	def value_size
		self.each_pair do |k,v|
			return v.size
		end
	end

	def update(digital, analog)
		@data = [digital, analog]
	end

	def read_data
		p self
		@data
	end
end
