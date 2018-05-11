class SlotMachine
  require 'colorize'
  #require_relative 
  attr_accessor :bet

  def welcome
    puts "Welcome to the Team RamRod Casino's slot machine."
  end


  def slot_main
    @slot_image = ['Bell', 'Apple', 'Star', 'orange', 'square', 'circle', 'pear']
    @cash = 100
    puts "You have $#{@cash} to play with."
    puts "Enter your bet to spin. "
    @bet = gets.to_i
    
    if @bet < 1
      puts "Minimum bet is $1.  Please re-enter bet. "
      @bet = gets.to_i
    else
      puts "You bet $#{@bet}"
    end

    @cash -= @bet
  end
  
  def slot_spin
    @s1 = @slot_image.sample
    @s2 = @slot_image.sample
    @s3 = @slot_image.sample

    puts "#{@s1}, #{@s2}, #{@s3}" 
  end

  def multipliers

    if @s1 == @s2 && @s2 == @s3 && @s1 == @s3
      @multiplier = 3
    elsif @s1 == @s2 || @s2 == @s3 || @s1 == @s3 || @s2 == @s3
      @multiplier = 2
    else
      @multiplier = 0
    end
  end

  def player_winnings
    winnings = @bet * @multiplier
    if @multiplier == 3 || @multiplier == 2
    total = winnings + @cash
    else
      total = @cash
    end

    puts "You won $#{winnings} your total is $#{total}."
  end

end

slots = SlotMachine.new

slots.welcome
slots.slot_main
slots.multipliers
slots.slot_spin
slots.player_winnings



