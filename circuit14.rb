# Conversion of arduino sample circuit 14 cpp code to Ruby
require 'dino'

# Get us an arduino board instantiated
board = Dino::Board.new(Dino::TxRx.new)
# Pin definitions:
# The 74HC595 uses a type of serial connection called SPI
# (Serial Peripheral Interface) that requires three pins:

datapin = 2; 
clockpin = 3;
latchpin = 4;

# We'll also declare a global variable for the data we're
# sending to the shift register:

data = "";


def setup()
{
  # Set the three SPI pins to be outputs:

  board.set_pin_mode(OUT, datapin)
  board.set_pin_mode(OUT, clockpin)
  board.set_pin_mode(OUT, latchpin)

}

# Send the data byte to the shift register:
board.write(data)
{
	#This that and the other

}

board.bitWrite(data)
{
	#This that and the other
}

def loop()
{
  # We're going to use the same functions we played with back
  # in circuit 04, "Multiple LEDs", we've just replaced
  # digitalWrite() with a new function called shiftWrite()
  # (see below). We also have a new function that demonstrates
  # binary counting.

  # To try the different functions below, uncomment the one
  # you want to run, and comment out the remaining ones to
  # disable them from running.
  
  oneAfterAnother();      # All on, all off
  
  #oneOnAtATime();       # Scroll down the line
  
  #pingPong();           # Like above, but back and forth

  #randomLED();          # Blink random LEDs
  
  #marquee();

  #binaryCount();        # Bit patterns from 0 to 255
}

def shiftWrite(desiredPin, desiredState)

# This function lets you make the shift register outputs
# on or off in exactly the same way that you use digitalWrite().

# Like digitalWrite(), this function takes two parameters:

#    "desiredPin" is the shift register output pin
#    you want to affect (0-7)

#    "desiredState" is whether you want that output
#    to be on or off

# Inside the Arduino, numbers are stored as arrays of "bits",
# each of which is a single 1 or 0 value. Because a "byte" type
# is also eight bits, we'll use a byte (which we named "data"
# at the top of this sketch) to send data to the shift register.
# If a bit in the byte is "1", the output will be on. If the bit
# is "0", the output will be off.

# To turn the individual bits in "data" on and off, we'll use
# a new Arduino commands called bitWrite(), which can make
# individual bits in a number 1 or 0.
{
  # First we'll alter the global variable "data", changing the
  # desired bit to 1 or 0:

  bitWrite(data,desiredPin,desiredState);
  
  # Now we'll actually send that data to the shift register.
  # The shiftOut() function does all the hard work of
  # manipulating the data and clock pins to move the data
  # into the shift register:

  shiftOut(datapin, clockpin, MSBFIRST, data);

  # Once the data is in the shift register, we still need to
  # make it appear at the outputs. We'll toggle the state of
  # the latchPin, which will signal the shift register to "latch"
  # the data to the outputs. (Latch activates on the on-to
  # -off transition).

      # Toggle the latch pin to make the data appear at the outputs:
  board.digital_write(on, latchpin);
  board.digital_write(off, latchpin);
}


=begin
oneAfterAnother()

This function will light one LED, delay for delayTime, then light
the next LED, and repeat until all the LEDs are on. It will then
turn them off in the reverse order.
=end

def oneAfterAnother()
{
  index = 0;
  delayTime = 100; # Time (milliseconds) to pause between LEDs
                       # Make this smaller for faster switching

  # Turn all the LEDs on:
 
  # This for() loop will step index from 0 to 7
  # (putting "++" after a variable means add one to it)
  # and will then use digitalWrite() to turn that LED on.
  
  for(index = 0; index <= 7; index++)
  {
    shiftWrite(index, off);
    delay(delayTime);                
  }

  # Turn all the LEDs off:

  # This for() loop will step index from 7 to 0
  # (putting "--" after a variable means subtract one from it)
  # and will then use digitalWrite() to turn that LED off.
 
  for(index = 7; index >= 0; index--)
  {
    shiftWrite(index, off);
    delay(delayTime);
  }
}

 
=begin
oneOnAtATime()

This function will step through the LEDs, lighting one at at time.
=end

def oneOnAtATime()
{
  index = 0;
  delayTime = 100; # Time (milliseconds) to pause between LEDs
                       # Make this smaller for faster switching
  
  # step through the LEDs, from 0 to 7
  
  for(index = 0; index <= 7; index++)
  {
    shiftWrite(index, on);	# turn LED on
    delay(delayTime);		# pause to slow down the sequence
    shiftWrite(index, off);	# turn LED off
  }
}

 
=begin
pingPong()

This function will step through the LEDs, lighting one at at time,
in both directions.
=end

def pingPong()
{
  index = 0;
  delayTime = 100; # time (milliseconds) to pause between LEDs
                       # make this smaller for faster switching
  
  # step through the LEDs, from 0 to 7
  
  for(index = 0; index <= 7; index++)
  {
    shiftWrite(index, on);	# turn LED on
    delay(delayTime);		# pause to soff down the sequence
    shiftWrite(index, off);	# turn LED off
  }

  # step through the LEDs, from 7 to 0
  
  for(index = 7; index >= 0; index--)
  {
    shiftWrite(index, on);	# turn LED on
    delay(delayTime);		# pause to slow down the sequence
    shiftWrite(index, off);	# turn LED off
  }
}


=begin
randomLED()

This function will turn on random LEDs. Can you modify it so it
also lights them for random times?
=end

def randomLED()
{
  index = 0;
  delayTime = 100; # time (milliseconds) to pause between LEDs
                       # make this smaller for faster switching
  
  # The random() function will return a semi-random number each
  # time it is called. See http:#arduino.cc/en/Reference/Random
  # for tips on how to make random() more random.
  
  index.rand(8) ;	# pick a random number between 0 and 7
  
  shiftWrite(index, on);	# turn LED on
  delay(delayTime);		# pause to soff down the sequence
  shiftWrite(index, off);	# turn LED off
}


=begin
marquee()

This function will mimic "chase lights" like those around signs.
=end

def marquee()
{
  index = 0;
  delayTime = 200; # Time (milliseconds) to pause between LEDs
                       # Make this smaller for faster switching
  
  # Step through the first four LEDs
  # (We'll light up one in the lower 4 and one in the upper 4)
  
  for(index = 0; index <= 3; index++)
  {
    shiftWrite(index, on);    # Turn a LED on
    shiftWrite(index+4, on);  # Skip four, and turn that LED on
    delay(delayTime);		# Pause to slow down the sequence
    shiftWrite(index, off);	# Turn both LEDs off
    shiftWrite(index+4, off);
  }
}


=begin
binaryCount()

Numbers are stored internally in the Arduino as arrays of "bits",
each of which is a 1 or 0. Just like the base-10 numbers we use
every day, The position of the bit affects the magnitude of its 
contribution to the total number:

Bit position   Contribution
0              1
1              2
2              4
3              8
4              16
5              32
6              64
7              128

To build any number from 0 to 255 from the above 8 bits, just
select the contributions you need to make. The bits will then be
1 if you use that contribution, and 0 if you don't.

This function will increment the "data" variable from 0 to 255
and repeat. When we send this value to the shift register and LEDs,
you can see the on-off pattern of the eight bits that make up the
byte. See http:#www.arduino.cc/playground/Code/BitMath for more
information on binary numbers.
=end


def binaryCount()
{
  delayTime = 1000; # time (milliseconds) to pause between LEDs
                        # make this smaller for faster switching
  
  # Send the data byte to the shift register:

  shiftOut(datapinout, clockpinout, MSBFIRST, data);

  # Toggle the latch pin to make the data appear at the outputs:

  digitalWrite(latchpinout, on);
  digitalWrite(latchpinout, off);
  
  # Add one to data, and repeat!
  # (Because a byte type can only store numbers from 0 to 255,
  # if we add more than that, it will "roll around" back to 0
  # and start over).

  data++;

  # Delay so you can see what's going on:

  delay(delayTime);
}