require_relative 'deck'
require_relative 'player'
require 'net/http'
require 'json'



class Game
  def initialize(num_players = 2)
    @num_players = num_players
    @players = []
    @round_count = 0
    setup_game
  end
  
  def setup_game
    deck = Deck.new
    hands = deck.deal(@num_players)
    
    @num_players.times do |i|
      @players << Player.new("Player #{i + 1}", hands[i])
    end
    
    puts "Starting War with #{@num_players} players!"
    puts "Each player starts with #{@players[0].card_count} cards."
    puts
  end
  
  def play
    while !game_over?
      @round_count += 1
      puts "Round #{@round_count}"
      puts "-" * 40
      sleep(0.02) # Otherwise it burns through instantly.
      play_round
      puts
    end
    
    announce_winner
  end
  
  private
  
  def play_round
    active_players = @players.select(&:has_cards?)
    pot = []
    
    loop do
      # Each active player plays a card
      current_cards = []
      current_players = []
      
      active_players.each do |player|
        next unless player.has_cards? && (card = player.play_card)
        current_cards << card
        current_players << player
        puts "#{player.name} plays: #{card}"
      end
      
      # Add all played cards to the pot
      pot.concat(current_cards)
      
      # Find the highest card(s)
      if current_cards.empty?
        break
      end
      
      # Find the highest card value played this round
      card_values = current_cards.map(&:rank_value)
      highest_value = card_values.max
      
      # Find all players who played the highest card
      winners = []
      current_players.each_with_index do |player, i|
        if current_cards[i].rank_value == highest_value
          winners << player
        end
      end
      
      # If only one winner, they take the pot
      if winners.size == 1
        winner = winners.first
        winner.receive_cards(pot.shuffle)
        puts "#{winner.name} wins #{pot.size} cards."
        break
      end
      
      # Multiple players tied
      puts "WAR! Multiple players have equal cards."
      
      # Remove players who can't continue from active players
      active_players = winners.select(&:has_cards?)
      
      # Each player in war puts down 3 cards
      active_players.each do |player|
        war_cards = player.play_cards(3)
        pot.concat(war_cards)
        puts "#{player.name} puts down #{war_cards.size} cards"
      end
      
      # Remove any players who are now out of cards
      active_players.select!(&:has_cards?)
      
      # If only one player left, they win by default
      if active_players.size == 1
        winner = active_players.first
        winner.receive_cards(pot.shuffle)
        puts "#{winner.name} wins the war by default!"
      end
      break if active_players.size <= 1
    end
    display_scores
  end
  
  def display_scores
    puts "\nCurrent card counts:"
    @players.each do |player|
      status = player.has_cards? ? "#{player.card_count} cards" : "ELIMINATED"
      puts "  #{player.name}: #{status}"
    end
  end
  
  def game_over?
    players_with_cards = @players.select(&:has_cards?)
    players_with_cards.size <= 1
  end
  
  def get_long_game_complaint
    complaints = [
      "I've seen paint dry faster than that game.",
      "We could have colonized Mars in that time.",
      "That took longer than my last software update.",
      "I could have learned a new programming language in that time.",
      "Even my loading bars didn't take that long.",
      "Was this game running on dial-up?",
      "I've debugged infinite loops shorter than that.",
      "That took longer than a Windows 95 boot sequence.",
      "My code compiles faster than that game took to finish.",
      "Even npm install was faster than that."
    ]
    complaints.sample
  end

  def announce_winner
    winner = @players.find(&:has_cards?)
    divider = "=" * 40
    
    puts "\n#{divider}"
    puts "GAME OVER!"
    
    if winner && @round_count > 20
      puts get_long_game_complaint
    end
    
    puts winner ? "#{winner.name} wins with all 52 cards." : "Game ended in a draw."
    puts "Total rounds played: #{@round_count}"
    puts divider
  end
end