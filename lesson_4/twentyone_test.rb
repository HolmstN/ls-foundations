require 'pry'

ALL_CARDS = ['Jack', 'Queen', 'King'] + (2..10).to_a  # ACES CURRENTLY NOT ADDED
SUIT_NAMES = %w(S pades Hearts Clubs Diamonds)
NUMBER_CARDS = (2..10).to_a
ROYAL_CARDS = %w(Jack Queen King)

player_hand = [[:spades, 5], [:hearts, 'Jack']]

def card_totals(hand)
  total = 0
  num_aces = 0
  hand.each_index do |index|  # iterate through hand with calculate_card_worth
    if hand[index][1] == 'Ace'
      num_aces += 1
    else
      puts "1: #{total}"
      total += calculate_card_worth(hand[index][1])
      puts "2: #{total}"
    end
  end
  puts "3: #{total}"
  total
end

def calculate_card_worth(card)
  if NUMBER_CARDS.include?(card)  # if card is a number, worth its number
    card.to_i
  elsif ROYAL_CARDS.include?(card)  # if card is a face, worth 10
    10
  else  # if card is an ace, calculate 0 for now.
    0
  end
end

def bust?(hand)
  busted = card_totals(hand) > 21
  !!busted
end

binding.pry
