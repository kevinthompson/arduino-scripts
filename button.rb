require 'rubygems'
require 'dino'
require 'httparty'
require 'json'

board  = Dino::Board.new(Dino::TxRx.new)
button = Dino::Components::Button.new(pin: 13, board: board)
led    = Dino::Components::Led.new(pin: 12, board: board)

button.down do
  response = HTTParty.post('http://192.168.1.100:4567')
  puts response
  count = response['button_presses']
  puts "The button has been pressed #{count} time#{count > 1 ? 's' : ''}. Result: #{count % 5}"

  if count % 10 == 0
    led.send :off
  elsif count % 5 == 0
    led.send :on
  end

end

button.up do
end

sleep