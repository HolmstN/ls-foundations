# Mortgage Calculator

def prompt(text)
  puts "=> #{text}"
end

def valid_number?(num)
  /^\d+$/.match(num)
end

def valid_float?(num)
  /\d/.match(num) && /^\d*\.?\d*$/.match(num)
end

def calculate_payment(amount, interest, months)
  # use monthly interest rate
  amount * ((interest * (1 + interest)**months) / ((1 + interest)**months - 1))
end

def check_end
  check = gets.chomp
  check.downcase.start_with? 'y'
end

loop do
  principal = ''
  apr = ''
  loan_years = ''

  loop do
    prompt 'How much would you like a loan for?'
    principal = gets.chomp
    if valid_number?(principal)
      break
    else
      prompt "That doesn't appear to be a valid number.  No decimals, please."
    end
  end

  loop do
    prompt 'What is your expected APR? Format like: 5 or 2.5'
    apr = gets.chomp
    if valid_float?(apr)
      break
    else
      prompt 'That doesn\'t appear to be a valid number.'
    end
  end

  loop do
    prompt "In how many years would you like to pay off your loan?"
    loan_years = gets.chomp
    if valid_number?(loan_years)
      break
    else
      prompt 'That doesn\'t appear to be a valid number.  No decimals, please.'
    end
  end

  check_prompt = <<-MSG
    You've entered the following information:
    Principal: #{principal}
    APR: #{apr}
    Loan Duration: #{loan_years}
    Is that correct?  Y to move forward.
    MSG

  prompt(check_prompt)

  break unless check_end

  loan_months = loan_years.to_i * 12
  annual_interest = apr.to_f / 100
  monthly_interest = annual_interest / 12

  monthly_payment = calculate_payment(principal.to_i, monthly_interest, loan_months)

  prompt "You will owe #{monthly_payment} per month."

  prompt 'Perform another calculation?  If so, press Y'
  break unless check_end
end
