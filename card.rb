class Card
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[♠ ♥ ♦ ♣].freeze
  
  attr_reader :rank, :suit
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def rank_value
    RANKS.index(@rank)
  end
  
  def to_s
    "#{@rank} #{@suit}"
  end
end