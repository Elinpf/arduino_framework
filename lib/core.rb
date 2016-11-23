#/usr/bin/env ruby
$:.unshift File.expand_path('.')

# require The Arduino_Firmata 
require "arduino_firmata"

# The core framework
require "core/arduino_framework"
require "core/constant"
require "core/store"

# The modules
require "module"
