# Mortgage Calculator

def prompt(message)
  Kernel.puts("=> #{message}")
end

prompt("Welcome to the mortgage calculator! Please input the necessary information when prompted.")

# Collect user input
loan_amount = nil
prompt("Please enter the loan amount (rounded to the nearest dollar): ")
loop do
  loan_amount = Kernel.gets().chomp()
  if (loan_amount.to_i().to_s() == loan_amount) && (loan_amount.to_i() > 0)
    break
  else
    prompt("Please enter a valid number!")
  end
end

apr = nil
prompt("Please enter the annual percentage rate (APR) as percentage (e.g. 6.0, 4.2, 3.1): ")
loop do
  apr = Kernel.gets().chomp()
  if (apr.to_f().to_s() == apr) && (apr.to_f()> 0.0)
    break
  else
    prompt("Please eneter a valid percentage!")
  end
end


loan_duration = nil
prompt("Please enter the loan duration (in months): ")
loop do
  loan_duration = Kernel.gets().chomp()
  if (loan_duration.to_i().to_s() == loan_duration) && (loan_duration.to_i() > 0)
    break
  else
    prompt("Please enter a valid number of months!")
  end
end

# Conversions
monthly_ir = (apr.to_f() / 12) / 100
loan_amount = loan_amount.to_i()
loan_duration = loan_duration.to_i()

# Calculations
prompt("Calculating monthly payment...")

monthly_payment = loan_amount * (monthly_ir / (1 - (1 + monthly_ir)**-loan_duration)).round(2)

prompt("Your monthly payment is: $#{monthly_payment}!")





