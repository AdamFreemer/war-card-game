class Player
  attr_reader :name, :cards
  
  def initialize(name, cards = [])
    @name = name
    @cards = cards
  end
  
  def play_card
    @cards.shift
  end
  
  def play_cards(count)
    cards_to_play = []
    count.times do
      break if @cards.empty?
      cards_to_play << @cards.shift
    end
    cards_to_play
  end
  
  def receive_cards(won_cards)
    @cards.concat(won_cards)
  end
  
  def has_cards?
    !@cards.empty?
  end
  
  def card_count
    @cards.size
  end
end