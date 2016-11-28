load "core.rb"

board = ArduinoFramework.new

board = Module_::Rocker.new(board)
board.start
board.rocker_setup 0,1,4

sleep 2
p board.store.read_data

