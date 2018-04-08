# Twenty-One Game

# Constants 

DECK = [['H', '2'], ['H', '3'], ['H', '4'], ['H', '5'], ['H', '6']] +
       [['H', '7'], ['H', '8'], ['H', '9'], ['H', '10']] +
       [['H', 'J'], ['H', 'Q'], ['H', 'K'], ['H', 'A']] + 
       [['D', '2'], ['D', '3'], ['D', '4'], ['D', '5'], ['D', '6']] +
       [['D', '7'], ['D', '8'], ['D', '9'], ['D', '10']] +
       [['D', 'J'], ['D', 'Q'], ['D', 'K'], ['D', 'A']] + 
       [['C', '2'], ['C', '3'], ['C', '4'], ['C', '5'], ['C', '6']] +
       [['C', '7'], ['C', '8'], ['C', '9'], ['C', '10']] +
       [['C', 'J'], ['C', 'Q'], ['C', 'K'], ['C', 'A']] + 
       [['S', '2'], ['S', '3'], ['S', '4'], ['S', '5'], ['S', '6']] +
       [['S', '7'], ['S', '8'], ['S', '9'], ['S', '10']] +
       [['S', 'J'], ['S', 'Q'], ['S', 'K'], ['S', 'A']]


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
    card_template()
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
  new_deck = DECK
end

def deal_cards!(deck, p_cards, d_cards)
  p_cards[0] = deck.shuffle!.pop
  p_cards[1] = deck.shuffle!.pop
  d_cards[0] = deck.shuffle!.pop
  d_cards[1] = deck.shuffle!.pop
  return p_cards, d_cards
end

def determine_values(cards)
  values = cards.map { |card| card[1] }
  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value.to_i
    end
  end
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > 21
  end
  sum
end

def hit!(cards, deck)
  cards << deck.shuffle!.pop
end

def busted?(total)
  total > 21 
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

# Main
loop do
  winner = nil
  player_total = 0
  dealer_total = 0
  loop do
  # New game begins
    deck = initialize_deck
    player_cards, dealer_cards = [], []
    player_cards, dealer_cards = deal_cards!(deck, player_cards, dealer_cards)
    
    # Player Turn

    answer = nil
    player_total = determine_values(player_cards)
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
      display_cards(player_cards, dealer_cards)
      prompt "Ah, sorry, you busted with #{player_total}!"
      sleep(2)
      winner = 'dealer'
      break
    else
      prompt "You chose to stay!"
    end

    # Dealer Turn

    prompt "Dealer's turn!"
    sleep(1)
    loop do
      display_cards(player_cards, dealer_cards)
      dealer_total = determine_values(dealer_cards)
      break if dealer_total >= 17
      hit!(dealer_cards, deck)
      sleep(2)  
    end

    if busted?(dealer_total)
      display_cards_all(player_cards, dealer_cards)
      prompt "Dealer busted with #{dealer_total}!"
      sleep(2)
      winner = 'player'
      break
    else
      display_cards_all(player_cards, dealer_cards)
      prompt "Dealer opted to stay."
      sleep(2)
      break
    end
  end
  winner = determine_winner(player_total, dealer_total) if winner == nil
  display_winner(winner, player_total, dealer_total)

  prompt "Want to play again? Enter Y if yes, any other key if not."
  break unless gets.chomp.downcase.start_with?('y')
end
prompt "Thank you for playing!"









