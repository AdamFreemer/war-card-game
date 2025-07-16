#!/usr/bin/env ruby

require_relative 'game'

def main
  puts "Welcome to War!"
  puts "=" * 40
  
  game = Game.new(get_number_of_players)
  game.play
end

def get_number_of_players
  loop do
    print "How many players? (2 or 4): "
    input = gets.chomp
    
    if input == "2" || input == "4"
      return input.to_i
    else
      puts "Please enter 2 or 4 (the deck must divide evenly)."
    end
  end
end

main if __FILE__ == $0