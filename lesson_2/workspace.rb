# def choose_mark(brd)
  choice = []
  puts "First, choose 'X' or 'O': "
  mark_letter = gets.chomp
  loop do
    break unless mark_letter == 'X' || mark_letter == 'O'
    puts "That's not a valid option"
  end

  puts "Now, choose a spot one (1) through nine (9)"
  mark_spot = gets.chomp
  loop do
    break unless (1..9).cover?(mark_spot.to_i)
    puts "That's not a valid number.  See location options?  Press Y"

    response = gets.chomp

    loop do
      break unless response == 'Y'
      display_options
    end
  end
  choice << mark_letter
  choice << mark_spot
  choice
end
