# Tic Tac Toe
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +  # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +  # columns
                [[1, 5, 9], [3, 5, 7]]               # diagnols
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMP_MARKER = 'O'

# Display the tic-tac-toe board
# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(mark)
  system 'clear'
  puts ""
  puts "     |     |"
  puts "  #{mark[1]}  |  #{mark[2]}  |  #{mark[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{mark[4]}  |  #{mark[5]}  |  #{mark[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{mark[7]}  |  #{mark[8]}  |  #{mark[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def display_options # Show user board with locations marked.
  board_locs = {}
  (1..9).each { |num| board_locs[num] = num }
  display_board(board_locs)
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def choose_spot(brd)
  choice_spot = 0
  loop do
    puts "Pick a spot (#{empty_squares(brd).join(', ')}).  Type 'help' to see locations:"
    choice_spot = gets.chomp
    if empty_squares(brd).include?(choice_spot.to_i)
      break
    elsif choice_spot == 'help'
      display_options
    else
      puts "That's not a valid choice."
    end
  end
  brd[choice_spot.to_i] = PLAYER_MARKER
end

def find_best_square(line, brd)
  if brd.values_at(*line).count(COMP_MARKER) == 2
    brd.select{ |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  elsif brd.values_at(*line).count(PLAYER_MARKER) == 2
    brd.select{ |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

def computer_choice(brd)
  choice_spot = nil
  WINNING_LINES.each do |line|
    choice_spot = find_best_square(line, brd)
    break if choice_spot
  end

  if !choice_spot && brd[5] == INITIAL_MARKER
    choice_spot = 5
  end

  if !choice_spot
    choice_spot = empty_squares(brd).sample
  end

  brd[choice_spot] = COMP_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd[line[0]] == PLAYER_MARKER &&
       brd[line[1]] == PLAYER_MARKER &&
       brd[line[2]] == PLAYER_MARKER
      return 'Player'
    elsif brd[line[0]] == COMP_MARKER &&
          brd[line[1]] == COMP_MARKER &&
          brd[line[2]] == COMP_MARKER
      return 'Computer'
    end
  end
  nil
end

def joinor(input, separator=', ', conclude='or')
  last_item = input.pop
  "#{input.join(separator)} #{conclude} #{last_item}"
end

board = initialize_board
display_board(board)
loop do
  loop do
    display_board(board)
    # pick_turn(FIRST_PLAYER)
    choose_spot(board)
    break if someone_won?(board) || board_full?(board)
    computer_choice(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    puts "#{detect_winner(board)} won!"
  else
    puts "It's a tie!"
  end

  puts "Play again?  Enter 'Y'"
  answer = gets.chomp
  break unless answer.downcase.start_with? 'Y'
end

puts "Thanks for playing Tic Tac Toe. Goodbye!"
