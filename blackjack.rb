#blackjack game class
require 'pry'
require_relative 'cards'

class Blackjack

  def initialize
    @game_deck = Deck.new
  end

end

binding.pry