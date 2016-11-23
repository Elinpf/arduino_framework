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
	#	
	def has_pin?(k)
		raise "Must input Fixnum" unless k.kind_of? Fixnum
		self.has_key?(k) 
	end

	#
	# Insert pin val and Description
	# {pin =>[val, desc]}
	#
	def insert(pin, val, desc='')
		self[pin] = [val, desc]
	end
	
	def inspect
		super
	end
end
