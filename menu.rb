require 'colorize'
require_relative 'blackjack'

def menu
    puts "GAME MENU"
    puts "1) Black Jack"
    puts "2) Slot Machine"
    puts "3) War"
    puts "4) Quit"
end

def greeting
    puts "Hello WELCOME TO THE TEAM RAMROD CASINO!!"
end


def selections   
    choice = ""
    while choice != 4
        puts "Please choose a game to play:"
        choice = gets.to_i
        if choice == 1
            @dealer = Dealer.new
            @deck = Deck.new
            @dealer.dealer_shuffle(@deck)
            @dealer.deal(@deck, 2, true)
            @dealer.question(@deck)
        elsif choice == 2
            SlotMachine
        elsif choice == 3
            War
        elsif choice == 4
            puts "Come back soon!"
            exit
        end 
    end
end
   


greeting
menu
selections
