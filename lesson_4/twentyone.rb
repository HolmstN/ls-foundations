require 'pry'
ALL_CARDS = ['Jack', 'Queen', 'King', 'Ace'] + (2..10).to_a
SUIT_NAMES = %w(Spades Hearts Clubs Diamonds).freeze
NUMBER_CARDS = (2..10).to_a
ROYAL_CARDS = %w(Jack Queen King).freeze

def initialize_deck
  { spades: ALL_CARDS,
    hearts: ALL_CARDS,
    clubs: ALL_CARDS,
    diamonds: ALL_CARDS }
end

def prompt(msg)
  puts "==> #{msg}"
end

def display_card_name(card, suit)
  puts "|| #{card} of #{suit} ||"
end

def deal_cards(hand, dck, amount=1)
  amount.times do
    random_suit = dck.to_a.sample.first
    random_card = ALL_CARDS.sample
    hand << [random_suit, random_card]
    dck[random_suit].delete(random_card)
  end
end

def calculate_card_worth(card)
  if NUMBER_CARDS.include?(card) # if card is a number, worth its number
    card.to_i
  elsif ROYAL_CARDS.include?(card) # if card is a face, worth 10
    10
  else # if card is an ace, calculate 0 for now.
    0
  end
end

def display_cards(hand, say)
  prompt "#{say}: "
  hand.each_index do |index|
    display_card_name(hand[index][1], hand[index][0])
  end
end

def hit_or_stay?(input)
  if input.downcase == 'hit' || input.downcase == 'h'
    'hit'
  elsif input.downcase == 'stay' || input.downcase == 's'
    'stay'
  else
    nil
  end
end

def add_value_aces(num_aces, current_total)
  # aces must count last to allow this method to work
  # aka current_total needs to be all other cards combined
  count_aces = num_aces
  while count_aces > 0
    if (current_total + 11) <= 21
      current_total += 11
    else
      current_total += 1
    end
    count_aces -= 1
  end
  current_total
end

def card_totals(hand)
  total = 0
  num_aces = 0
  hand.each_index do |index|  # iterate through hand with calculate_card_worth
    if hand[index][1] == 'Ace'
      num_aces += 1
    else
      total += calculate_card_worth(hand[index][1])
    end
  end
  total = add_value_aces(num_aces, total) if num_aces > 0
  total
end

def bust?(hand)
  busted = card_totals(hand) > 21
  !!busted
end

# Game Loop
loop do
  loop do
    # Prepare Deck
    deck = initialize_deck
    player_hand = []
    dealer_hand = []

    # Deal cards
    deal_cards(player_hand, deck, 2)
    deal_cards(dealer_hand, deck, 2)

    display_cards(dealer_hand, "Dealer has")

    # Player turn
    loop do
      # display current score
      display_cards(player_hand, "You have")

      # ask player 'stay' or 'hit'
      prompt 'Stay or hit?'
      player_response = ''
      loop do
        player_response = gets.chomp
        break if hit_or_stay?(player_response)
        prompt "That's not a valid answer."
      end
      player_response = hit_or_stay?(player_response)

      # if 'hit' check for bust, then loop
      # if 'stay' move to computer
      break unless player_response == 'hit'
      deal_cards(player_hand, deck)
      if bust?(player_hand)
        display_cards(player_hand, "You have")
        break
      end
    end

    if bust?(player_hand)
      prompt "You busted with #{card_totals(player_hand)}!"
      break
    end

    # Dealer turn
    loop do
      # display current score
      display_cards(dealer_hand, "Dealer has")
      sleep 1
      puts '.'
      sleep 1
      puts '.'
      sleep 1
      puts '.'

      # if dealer card total <= 17, then 'hit' else 'stay'
      if card_totals(dealer_hand) <= 17
        prompt "Hit."
        deal_cards(dealer_hand, deck)
        sleep 2
        if bust?(dealer_hand)
          break
        end
      else
        prompt "Stay."
        sleep 1
        break
      end
    end

    if bust?(dealer_hand)
      prompt "Dealer busted with #{card_totals(dealer_hand)}, you win!"
      break
    end

    # If both 'stay', compare values.  Whoever is higher wins, or a match is a tie.
    if card_totals(player_hand) > card_totals(dealer_hand)
      prompt "Congratulations, you won!"
    elsif card_totals(player_hand) < card_totals(dealer_hand)
      prompt "Sorry, the dealer won this time."
    else
      prompt "It's a tie!"
    end

    puts "===================="
    prompt 'Final score'
    prompt "Player: #{card_totals(player_hand)}"
    prompt "Dealer: #{card_totals(dealer_hand)}"
    puts "===================="
    break
  end

  prompt "Play again? press Y"
  play_again = gets.chomp
  break unless play_again.downcase == 'y'
end

prompt 'Thanks for playing!'
