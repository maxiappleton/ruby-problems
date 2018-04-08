# Twenty-One Game - Refactored

# Constants

SUITS = ['H', 'D', 'S', 'C'].freeze
VALUES = ['2', '3', '4', '5', '6', '7'] +
         ['8', '9', '10', 'J', 'Q', 'K', 'A'].freeze
WINNING_SCORE = 21
DEALER_MAX = 17

# Methods

def prompt(msg)
  puts " => #{msg}"
end

def card_template(card = ['-', '-'])
  if card[1] == '10'
    puts " ----------- "
    puts "|           |"
    puts "|    #{card[0]} #{card[1]}   |"
    puts "|           |"
    puts " ----------- "
  else
    puts " ----------- "
    puts "|           |"
    puts "|    #{card[0]} #{card[1]}    |"
    puts "|           |"
    puts " ----------- "
  end
end

def display_cards(p_cards, d_cards)
  system 'clear'
  puts ""
  prompt "Player Cards:"
  p_cards.size.times do |cardnum|
    card_template(p_cards[cardnum])
  end
  puts ""
  prompt "Dealer Cards:"
  card_template(d_cards[0])
  (d_cards.size - 1).times do
    card_template
  end
end

def display_cards_all(p_cards, d_cards)
  system 'clear'
  puts ""
  prompt "Player Cards:"
  p_cards.size.times do |cardnum|
    card_template(p_cards[cardnum])
  end
  puts ""
  prompt "Dealer Cards:"
  d_cards.size.times do |cardnum|
    card_template(d_cards[cardnum])
  end
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def determine_values(cards)
  values = cards.map { |card| card[1] }
  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i.zero?
      sum += 10
    else
      sum += value.to_i
    end
  end
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > WINNING_SCORE
  end
  sum
end

def hit!(cards, deck)
  cards << deck.pop
end

def busted?(total)
  total > WINNING_SCORE
end

def determine_winner(p_total, d_total)
  return 'player' if p_total > d_total
  return 'dealer' if p_total < d_total
  'draw'
end

def display_winner(winner, p_total, d_total)
  prompt "Player final score: #{p_total}"
  prompt "Dealer final score: #{d_total}"
  case winner
  when 'draw'
    prompt "The final result is a draw!"
  when 'player'
    prompt "Congratulations! You are victorious!"
  when 'dealer'
    prompt "Awww, the dealer won - better luck next time!"
  end
end

def play_again?
  puts "-------------"
  prompt "Want to play again? Enter Y if yes, any other key if not."
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

# Main
loop do
  winner = nil
  player_total = 0
  dealer_total = 0
  loop do
    system 'clear'
    puts ""
    prompt "Welcome to 21!"
    prompt "Shuffling and dealing cards..."
    sleep(2)
    deck = initialize_deck
    player_cards = []
    dealer_cards = []
    2.times do
      player_cards << deck.pop
      dealer_cards << deck.pop
    end
    player_total = determine_values(player_cards)
    dealer_total = determine_values(dealer_cards)

    # Player Turn

    answer = nil
    loop do
      display_cards(player_cards, dealer_cards)
      loop do
        prompt "Hit or Stay? Enter 'h' to hit, enter 's' to stay."
        prompt "Your current total: #{player_total}"
        answer = gets.chomp.downcase
        break if answer == 's' || answer == 'h'
        prompt "Please enter a valid answer!"
      end
      hit!(player_cards, deck) if answer == 'h'
      player_total = determine_values(player_cards)
      break if answer == 's' || busted?(player_total)
    end

    if busted?(player_total)
      display_cards_all(player_cards, dealer_cards)
      prompt "Ah, sorry, you busted with #{player_total}!"
      sleep(2)
      winner = 'dealer'
      break
    else
      prompt "You chose to stay at #{player_total}!"
      sleep(1)
    end

    # Dealer Turn

    prompt "Dealer's turn!"
    sleep(1)
    loop do
      display_cards(player_cards, dealer_cards)
      sleep(2)
      dealer_total = determine_values(dealer_cards)
      break if dealer_total >= DEALER_MAX
      hit!(dealer_cards, deck)
    end

    if busted?(dealer_total)
      display_cards_all(player_cards, dealer_cards)
      prompt "Dealer busted with #{dealer_total}!"
      sleep(2)
      winner = 'player'
      break
    else
      display_cards_all(player_cards, dealer_cards)
      prompt "Dealer opted to stay at #{dealer_total}."
      sleep(2)
      break
    end
  end
  winner = determine_winner(player_total, dealer_total) if winner.nil?
  display_winner(winner, player_total, dealer_total)

  break unless play_again?
end
prompt "Thank you for playing!"
