require 'dino'

DELAY_TIME = 0.1 # Seconds
board = Dino::Board.new(Dino::TxRx.new)
status = Dino::Components::Status.new(pin: 13, board: board)

# Instantiate LED Objects
leds = (2..9).map do |pin|
  Dino::Components::Led.new(pin: pin, board: board)
end

# Wait Until Arduino is Ready
sleep(0.1) until status.ready

begin
  # Turn Each LED On
  leds.each do |led|
    puts "Turning pin ##{led.pin} on..."
    led.on
    sleep DELAY_TIME
  end

  # Turn Each LED Off
  leds.reverse.each do |led|
    puts "Turning pin ##{led.pin} off..."
    led.off
    sleep DELAY_TIME
  end
ensure
  puts 'Ensuring all LEDs are turned off...'
  leds.each do |led|
    led.off
  end
end