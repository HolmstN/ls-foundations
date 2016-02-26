require 'pry'

VALID_CHOICES = %w(rock paper scissors lizard spock)
ROCK = %w(rock r)
SCISSORS = %w(scissors sc)
PAPER = %w(paper p)
LIZARD = %w(lizard l)
SPOCK = %w(spock sp)

CHOICE_OPTIONS = %w(rock paper scissors lizard spock r sc p l sp)

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  case
  when ROCK.include?(first)
    SCISSORS.include?(second) || LIZARD.include?(second)
  when PAPER.include?(first)
    ROCK.include?(second) || SPOCK.include?(second)
  when SCISSORS.include?(first)
    PAPER.include?(second) || LIZARD.include?(second)
  when LIZARD.include?(first)
    SPOCK.include?(second) || PAPER.include?(second)
  when SPOCK.include?(first)
    SCISSORS.include?(second) || ROCK.include?(second)
  end
end

def display_results(player, computer)
  if win?(player, computer)
    prompt "You won!"
  elsif win?(computer, player)
    prompt "Computer won!"
  else
    prompt "It's a tie!"
  end
end

loop do
  prompt "First to five wins."
  player_wins = 0
  computer_wins = 0
  choice = ''
  loop do
    loop do
      prompt "choose one: #{VALID_CHOICES.join(", ")}"
      choice = gets.chomp

      if CHOICE_OPTIONS.include?(choice)
        break
      else
        prompt "That's not a valid choice."
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt "You chose #{choice}.  Computer chose #{computer_choice}"

    display_results(choice, computer_choice)

    bonus_prompt = <<-MSG
    Did you know you can use these short-hands?
    Rock = 'r'
    Scissors = 'sc'
    Paper = 'p'
    Lizard = 'l'
    Spock = 'sp'
    MSG

    prompt(bonus_prompt) if player_wins == 3 || computer_wins == 3

    if win?(choice, computer_choice)
      player_wins += 1
    elsif win?(computer_choice, choice)
      computer_wins += 1
    end

    if player_wins == 5
      prompt "***** You win! *****"
      break
    elsif computer_wins == 5
      prompt "***** Computer wins! *****"
      break
    else
      prompt "You have #{player_wins} wins vs computer has #{computer_wins} wins."
    end
  end

  prompt "Do you want to play again? Press Y"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing. Bye!"
