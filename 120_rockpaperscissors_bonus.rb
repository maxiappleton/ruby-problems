# Rock Paper Scissors

# Constants
VALID_CHOICES = %w(rock paper scissors lizard spock)

RESULTS_HASH = {
  'rock' => %w(scissors lizard),
  'paper' => %w(rock spock),
  'scissors' => %w(paper lizard),
  'lizard' => %w(paper spock),
  'spock' => %w(rock scissors)
}

SHORTCUTS = {
  'r' => 'rock',
  'p' => 'paper',
  'sc' => 'scissors',
  'l' => 'lizard',
  'sp' => 'spock'
}

# Methods
def prompt(message)
  Kernel.puts("=> #{message}")
end

def convert_to_word(letter)
  SHORTCUTS[letter]
end

def win?(first, second)
  RESULTS_HASH[first].include?(second)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won this round!")
  elsif win?(computer, player)
    prompt("Computer won this round!")
  else
    prompt("It's a tie!")
  end
end

def clear_screen
  system('clear') || system('cls')
end

# Main Program
loop do
  player_wins = 0
  computer_wins = 0
  clear_screen
  prompt("First to 5 wins!")

  loop do
    choice = nil
    loop do
      prompt("Choose one: (r)rock, (p)paper, (sc)scissors, (l)lizard, (sp)spock")
      answer = Kernel.gets().chomp()
      choice = convert_to_word(answer)
      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice!")
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{choice}")
    prompt("Computer chose: #{computer_choice}")

    display_results(choice, computer_choice)

    if win?(choice, computer_choice)
      player_wins += 1
    elsif win?(computer_choice, choice)
      computer_wins += 1
    end

    prompt("Player victories: #{player_wins}")
    prompt("Computer victories: #{computer_wins}")

    puts("--------------------------------------------------------")

    if player_wins == 5
      prompt("YOU WIN!")
      prompt("Congrats! You're awesome!")
      break
    elsif computer_wins == 5
      prompt("COMPUTER WINS!")
      prompt("Awww, better luck next time!")
      break
    end
  end

  prompt("Enter Y to play again, or enter any other key to exit")
  break unless Kernel.gets().chomp().downcase().start_with?('y')
end

prompt("Thanks for playing!")
