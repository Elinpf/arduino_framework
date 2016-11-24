load "core.rb"

board = ArduinoFramework.new
board.reg_module(Rocker)
p board.rocker_set_all(0,1,7)

loop do
board.rocker_read_all
end

