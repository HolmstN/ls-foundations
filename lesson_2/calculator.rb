# ask user for two numbers
# ask the user for an operation
# perform the operation on the given nums
# output the result

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  /^\d+$/.match(num)
end

def float?(input)
  /\d/.match(input) && /^\d*\.?\d*$/.match(input)
end

def operation_to_message(op)
  case op
  when '1'
    return 'Adding'
  when '2'
    return 'Subtracting'
  when '3'
    return 'Multiplying'
  when '4'
    return e'Dividing'
  end
end

prompt "Welcome to CALCULATOR! Enter your name:"

name = ''
loop do
  name = gets.chomp
  if name.empty?
    prompt "Please use a valid name."
  else
    break
  end
end

prompt "Hey #{name}!"

loop do  # main loop
  number1 = ''
  loop do
    prompt "First number? "
    number1 = gets.chomp

    if valid_number?(number1)
      break
    else
      prompt "Hrm... that doesn't look like a valid number"
    end
  end

  number2 = ''
  loop do
    prompt "Second number? "
    number2 = gets.chomp

    if valid_number?(number2)
      break
    else
      prompt "Hrm... that doesn't look like a valid number"
    end
  end

  operator_prompt = <<-MSG
  What message would you like to perform?
  1) Add
  2) Subtract
  3) Multiply
  4) Divide
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt 'Must choose 1, 2, 3 or 4'
    end
  end

  prompt "#{operation_to_message(operator)} the two numbers..."

  result = case operator
           when '1'
             number1.to_i + number2.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
  end
  prompt "The result is #{result}"

  prompt "Do you want to perform another calculation? Y to calculate again"
  answer = gets.chomp
  break unless answer.downcase.start_with? 'y'
end

prompt "Thanks for using the calculator. Good bye!"
