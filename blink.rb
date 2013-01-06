require 'rubygems'
require 'dino'

board  = Dino::Board.new(Dino::TxRx.new)
sensor = Dino::Components::Sensor.new(pin: 'A0', board: board)
led    = Dino::Components::Led.new(pin: 13, board: board)

on_data = Proc.new do |data|
  led.off
  sleep data.to_f/1000
  led.on
end

sensor.when_data_received on_data

sleep