require 'pry'
require 'colorize'
require_relative 'cards'

d = Deck.new
deck = d.shuffle
#dealer gets two cards, shows player one
puts "\nLet's play Blackjack!".colorize(:green)
dealer_cards = []
puts "\n"
print "The dealer takes two cards. Showing a: "
dealer_cards << deck.shift
dealer_cards << deck.shift
puts dealer_cards[0].rank + " of " + dealer_cards[0].suit
#player gets two cards
player_cards = []
player_cards << deck.shift
player_cards << deck.shift
puts "You receive two cards: ".colorize(:light_green)
puts "1) #{player_cards[0].rank} of #{player_cards[0].suit}"
puts "2) #{player_cards[1].rank} of #{player_cards[1].suit}"

i = 2
while true
  puts "\n"
  puts "Your options are:".colorize(:light_blue)
  puts "1) Hit"
  puts "2) Stay"
  print "Your selection: "
  sel = gets.strip
  if sel == '1'
    puts "You selected HIT"
    player_cards << deck.shift
    puts "You received another card, which is a: "
    puts "#{player_cards[i].rank} of #{player_cards[i].suit}"
    i += 1
  elsif sel == '2'
    puts "You selected STAY"
    break
  else
    puts "Invalid input."
  end
end

#calculate totals for dealer and player
puts "The dealer shows you the other card - a: #{dealer_cards[1].rank} of #{dealer_cards[1].suit}"
#dealer total
@score = 0
i = 0
dealer_cards.length.times do |i|
  case dealer_cards[i].rank
  when 'A', 'Q', 'K', 'J'
    @score += 10
  else
    @score += dealer_cards[i].rank.to_i
  end
  i += 1
end
puts "The dealer's total is: #{@score}"
dealer_score = @score

#player total
@score = 0
i = 0
player_cards.length.times do |i|
  case player_cards[i].rank
  when 'A', 'Q', 'K', 'J'
    @score += 10
  else
    @score += player_cards[i].rank.to_i
  end
  i += 1
end
puts "Your total score is: #{@score}"
player_score = @score
if player_score > 21
  puts "Bust! You lose."
elsif player_score > dealer_score
  puts "You win!"
elsif player_score == dealer_score
  puts "It's a tie! Lol"
else
  puts "Dealer wins, sorry!"
end