load "core.rb"

board = ArduinoFramework.new

board = Module_::Rocker.new(board)
board.rocker_setup 0,1,7
p board.get_store

