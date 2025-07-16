require_relative 'card'

class Deck
  attr_reader :cards
  
  def initialize
    @cards = []
    build_deck
    shuffle!
  end
  
  def build_deck
    @cards = Card::SUITS.product(Card::RANKS).map { |suit, rank| Card.new(rank, suit) }
  end
  
  def shuffle!
    @cards.shuffle!
  end
  
  def deal(num_players)
    hands = Array.new(num_players) { [] }
    @cards.each_with_index do |card, index|
      hands[index % num_players] << card
    end
    
    hands
  end
end