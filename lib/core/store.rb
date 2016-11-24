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

	#
	# Insert pin val and Description
	# {Interface => [pin, val, tag, desc]
	#
	def insert(iface, pin, val, tag, desc='')
		self[iface] = [pin, val, tag, desc]
	end
	
	def inspect
		super
	end
end
