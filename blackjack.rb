require 'pry'
require 'byebug'
require 'colorize'
require_relative 'cards'

=begin
"It is never too late to reconsider everything"
  -Abraham Lincoln
=end

class Dealer

  def initialize
    @first_deal == true
    @player_cards = []
    @player_cards = []
    @blackjack = false
    @dealer_blackjack = false
    @done = false
    puts "\n          Blackjack lite       ".black.on_white
    puts "\n".colorize(:background => :black)
    puts "'Life is not a matter of holding good cards,".light_black
    puts "but of playing a poor hand well.'".light_black
    puts "                  - Robert Louis Stevenson".light_black
    puts "\n"
    sleep(2)
    puts "You approach the table and choose an empty chair. It's not too difficult,"
    puts "because they're all empty. The dealer is a disheveled, graying man with the"
    puts "distinct smell of liquor hanging around him."
    puts "\n"
    sleep(2)
    puts "An uncomfortably long time after you have sat down, the gentleman stirs"
    puts "from an unblinking stare (into eternity or something like that),"
    puts "and begrudgingly eases himself into what some might call 'attentive'."
    puts "\nDealer: <stares at you blearily>"
    puts "\n"
  end

  def check_blackjack(hand)
    first_card = hand[0]
    second_card = hand[1]
    if hand.length == 2
      if (first_card.rank == 'J' || first_card.rank == 'Q' || first_card.rank == 'K' || first_card.rank == '10') && second_card == 'A'
        @blackjack = true
      end
      if (second_card.rank == 'J' || second_card.rank == 'Q' || second_card.rank == 'K' || second_card.rank == '10') && first_card == 'A'
        @blackjack = true
      end
    end
    @blackjack
  end

  def dealer_shuffle(deck)
    puts 'The dealer shuffles the cards.'
    puts "\n"
    deck.shuffle
    @deck = deck
    @first_deal = true
    @player_cards = []
    @dealer_cards = []
  end

  def deal(deck_obj, num, first_deal)
    deck = deck_obj.shuffle
    if @first_deal == true && num == 2
      puts "He deals #{num} cards to himself."
      num.times do |i|
        @dealer_cards.push(deck.shift)
        if i == 0
          puts "You can see a #{@dealer_cards[i].rank} of #{@dealer_cards[i].suit}".light_red
        end
        if check_blackjack(@dealer_cards) == true
          @dealer_blackjack = true
        end
        sleep(2)
        i += 1
      end
      puts "\n"
      @first_deal = false
    end
    sleep(2)
    puts "The dealer puts #{num} cards in front of you:"
    num.times do
      @player_cards.push(deck.shift)
      puts "You see a #{@player_cards.last.rank} of #{@player_cards.last.suit}".light_blue
      sleep(2)
    end
    if check_blackjack(@player_cards) == true
      @blackjack = true
    end
    @deck = deck
  end

  def question(deck)
    while true
      bust_check = count_score(@player_cards).to_i
      if bust_check == 21
        puts "Dealer: 'Your hand is a blackjack!'"
        if @dealer_blackjack == true
          puts "Dealer: 'My hand is also blackjack, lol! What are the odds...'".light_green
          finish_round(bust_check, @deck)
        end
      elsif bust_check > 21
        puts "Dealer: 'You busted with a #{bust_check}.'"
        finish_round(bust_check, @deck)
      end
      dealer_bust_check = count_score(@dealer_cards).to_i
      if dealer_bust_check == 21
        puts "Dealer: I'm afraid you lose..\n".light_red
        finish_round(bust_check, @deck)
      end
      #If the code reaches here, neither player has won or lost yet.
      @dealer_questions = ["Make your choice.", "What'll you do now?", "I haven't got all day.", "Better think hard.", "I am waiting -patiently-.", "Don't think too hard about this one.", "Having fun yet?"]
      puts "\nDealer: '#{@dealer_questions.sample}'"
      puts "\nH) Hit"
      puts "S) Stand"
      puts "Q) Quit\n".colorize(:red)
      @choice = gets.strip
      if @choice == 'H'
        deal(deck, 1, false)
      elsif @choice == 'S'
        finish_round(bust_check, @deck)
      elsif @choice == 'Q'
        puts "\nDealer: <shrugs nonchalantly and resumes staring into the eternal void>\n\n"
        puts "-End of game-".black.on_white
        puts "\n"
        exit
      else
        puts "\nThe dealer looks at you quizzically.\n"
        puts "Dealer: 'You'll have to try again.'\n".light_red
      end
    end
  end
  
  def finish_round(bust_check, deck)
    @player_score = count_score(@player_cards)
    @dealer_score = count_score(@dealer_cards)
    puts "The dealer turns over his last card, to reveal a"
    puts "#{@dealer_cards.last.rank} of #{@dealer_cards.last.suit}.".light_red
    puts "Dealer: 'My total is #{@dealer_score}'"
    puts "Dealer: 'Your total is #{@player_score}'"
    if @dealer_score == 21 && @player_score == 21
      puts "Dealer: 'Wow, we both hit 21! That never happens.'".cyan
    elsif @dealer_score > 21
      puts "Dealer: 'Since I hit 21, I win.'".light_cyan
      puts "Dealer: 'You lose this round.'".light_red
    elsif @player_score == 21
      puts "Dealer: 'Since you've hit 21, you win this round.'".green
    elsif @player_score > 21
      puts "Dealer: 'I'm afraid you have lost this game.'".light_red
    elsif @player_score == @dealer_score
      puts "Dealer: 'It's a tie.' <yawns>\n".light_green
    elsif @player_score > @dealer_score
      puts "Dealer: 'Looks like you win this round, cowboy or -girl.'".light_cyan
    elsif @dealer_score > @player_score
      puts "Dealer: 'I'm afraid you lose this round, partner.'"
    end
    #clear the arrays for both hands
    @player_cards = []
    @dealer_cards = []
    end_game(deck)
  end

  def count_score(hand)
    @score = 0
    i = 0
    hand.length.times do |i|
      case hand[i].rank
      when 'Q', 'K', 'J'
        @score += 10
      when 'A'
        @score += 11
      else
        @score += hand[i].rank.to_i
      end
      i += 1
    end
  @score
  end
end

def end_game(deck)

  while true
    print "\nDealer: Another round? (Y/N)'\n"
    @choice = gets.strip
    if @choice == 'N'
      puts "\nDealer: 'Thanks for playing.'"
      puts "-End of game-".black.on_white
      puts "\n"
      @done == true
      exit
    elsif @choice == 'Y'
      @first_deal = true
      if deck.length < 12
        puts "Dealer: 'Hold on a second while I shuffle this deck.'"
        sleep(2)
        @deck = Deck.new
        dealer_shuffle(@deck)
      end
      deal(@deck, 2, true)
      break
    else
      puts "-Invalid input-\n"
    end
  end

end

@dealer = Dealer.new
@deck = Deck.new
@dealer.dealer_shuffle(@deck)
@dealer.deal(@deck, 2, true)
@dealer.question(@deck)
