#!/usr/bin/env ruby

#
# This classes is use for Store the temp data
# And provid 
#
class Store < Hash
	def initialize 
		super
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
	end
end
