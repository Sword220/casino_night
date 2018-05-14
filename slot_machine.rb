class SlotMachine
  require 'colorize'
  require 'pry' 
  attr_accessor :bet

  def welcome
    puts '-'.colorize(:green) * 50
    puts "Welcome to the Team RamRod Casino's slot machine."
    puts '-'.colorize(:green) * 50
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
    elsif @bet > @cash
      puts "You don't have enough money.  Try again."
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

    puts "#{@s1}, #{@s2}, #{@s3}".colorize(:red) 
  end

  def multipliers

    if @s1 == @s2 && @s2 == @s3 && @s1 == @s3
      @multiplier = 3
    elsif @s1 == @s2 || @s2 == @s3 
      @multiplier = 2
    else
      @multiplier = 0
    end

  end

  def player_winnings
    
    if @multiplier == 3 || @multiplier == 2
      winnings = @bet * @multiplier
    total = winnings + @cash
    else
     winnings = 0
     total = @cash
    end
    
    puts "You won $#{winnings} your total is $#{total}."
  
  end

end




