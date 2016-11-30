#!/usr/bin/env ruby

#
# This classes is use for Store the temp data
# And provid 
#
class Store < Hash
	def initialize 
		super
		@head = ["ID", "iface", "Pin", "mode",  "Description"]
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
		self.sheet	
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
		self
	end

	#
	# 这个方法是用来将Hash转化成为数组
	# 并且保证数组中没有进一步的数组
	#
	def to_a
		new_array = Array.new
		self.each_pair do |k,vs|
			new_array << k
			vs.each do |v|
				new_array << v
			end
		end
		return new_array
	end

	#
	# 按表格输出
	#
	def sheet
		num = @head.size
		tab_tmp = @head.clone

		col_size = Array.new
		cols = Array.new
		

		col_size << self.keys.sort{|x,y| x.size <=> y.size}[-1].size + 1
		tab_tmp.shift
		(num-1).times do |t|
			cols[t] = Array.new
			self.each_pair do |k,v|
				cols[t] << v[t]
			end
			cols[t].unshift tab_tmp[t]
		end

		cols.each do |col|
			col_size << col.sort {|x,y| 
				x.to_s.size <=> y.to_s.size}.last.size + 1
		end

		table = ""
		self.to_a.each_with_index do |val,i|
			val = val.to_s
			if i == 0
				table << "+"
				col_size.each do |t|
					table << "-" * t + "+"
				end
				table << "\n"
				@line_code = table.clone
				table << "|"
				@head.each_with_index do |h,i|
					table << h
					table << " " * (col_size[i] - h.size)
					table << "|"
				end
				table << "\n"
				table << @line_code
			end
			eve = i % col_size.size
			if eve == 0
				table << "|"
			end
			table << val
			table << " " * (col_size[eve] - val.size)
			table << "|"
			if eve == (col_size.size - 1)
				table << "\n"
				table << @line_code
			end
		end
		print table
	end
end
