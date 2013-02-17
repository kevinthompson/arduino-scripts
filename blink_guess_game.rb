require 'dino'

board = Dino::Board.new(Dino::TxRx.new)
low_led = Dino::Components::Led.new(pin: 10, board: board)
high_led = Dino::Components::Led.new(pin: 11, board: board)
correct_led = Dino::Components::Led.new(pin: 9, board: board)

def blink(led)
  led.send(:on)
  sleep 0.5
  led.send(:off)
  sleep 0.5
end

def celebrate(leds = Array.new(3), num_trys_left )
	puts "Celebrating by flashing #{leds.length} leds #{num_trys_left} times."
	num_trys_left.to_i.times do
		leds.each do
			| led | led.send(:on)
#			my_led = led
#			puts "#{my_led} is being turned on."
			sleep 0.250
		end
		sleep 1.00
		leds.reverse.each do
			| led | led.send(:off)
#			my_led = led
#			puts "#{my_led} is being turned off."
			sleep 0.250
		end
		sleep 1.00
	end
end


# 1. Generate a secret number between 0 and 10
secret = rand(100)
guess = nil
trys = 0
trys_left = 15
# 2. Ask the user to input a guess
print "Try to guess what number I have selected (between 0-100): "
# 4. Repeat until they guess correctly
until guess == secret || trys_left == 0
	guess = gets.chomp.to_i
	# 3. React to their guess using the LEDs
	if guess < 0 || guess > 100
		print "Enter a number between 0 and 100 only... "
		2.times do 
			[low_led, high_led].each { |n| blink(n) } 
		end
		trys += 1
		trys_left -= 1
	end
	if guess == secret
		trys += 1
		trys_left -= 1
		try_word = trys > 1 ? "tries" : "try"
		puts "Congratulations, it only too you #{trys} #{try_word} to guess my number!!!"
		puts "You had #{trys_left} #{ trys_left == 1 ? "try " : "tries " } left."
		celebrate([high_led, low_led, correct_led], trys_left)
=begin
		20.times do
			blink(correct_led)
		end 
=end
		exit
	end
	if guess < secret
		trys += 1
		trys_left -= 1
		print "Too low, guess again... "
		2.times do
			blink(low_led)
		end
	end
	if guess > secret
		trys += 1
		trys_left -= 1
		print "Too high, guess again... "
		2.times do
			blink(high_led)
		end
	end
end