# OO Twenty One

class Participant
  attr_accessor :hand, :name
  attr_reader :hand_value

  def initialize
    @name = nil
    @hand = []
    @hand_value = 0
  end

  def hit_from(deck)
    hand << deck.deal_one_card!
    calculate_hand_value
  end

  def busted?
    hand_value > Game::WINNING_SCORE
  end

  def display_all_cards
    hand.each(&:display_card)
  end

  def calculate_hand_value
    only_values = hand.map(&:face)

    sum = 0
    only_values.each do |face|
      sum += if face == 'A'
               11
             elsif face.to_i.zero?
               10
             else
               face.to_i
             end
    end
    only_values.count('A').times { sum -= 10 if sum > Game::WINNING_SCORE }

    @hand_value = sum
  end
end

class Player < Participant
  def set_name
    user_name = ''
    loop do
      puts "Before we get started - what's your name?"
      user_name = gets.chomp.capitalize.strip
      break unless user_name.empty?
      puts 'Sorry, you must enter a valid name.'
    end
    self.name = user_name
  end
end

class Dealer < Participant
  def initialize
    super
    @name = %w(Aido Cortana Viv).sample
  end

  def display_one_card
    hand.first.display_card
    (hand.size - 1).times { Card.display_back }
  end
end

class Deck
  SUITS = %w(H D S C).freeze
  VALUES = %w(2 3 4 5 6 7) +
           %w(8 9 10 J Q K A)

  attr_accessor :cards

  def initialize
    @cards = []
    cards_array = SUITS.product(VALUES)
    cards_array.each { |suit, face| @cards << Card.new(suit, face) }
    scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def deal!(participant)
    2.times { participant.hand << cards.pop }
    participant.calculate_hand_value
  end

  def deal_one_card!
    cards.pop
  end
end

class Card
  attr_reader :suit, :face
  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def display_card
    space = face == '10' ? 0 : 1
    puts ' ----------- '
    puts '|           |'
    puts "|    #{suit} #{face}   #{' ' * space}|"
    puts '|           |'
    puts ' ----------- '
  end

  def self.display_back
    puts ' ----------- '
    puts '|           |'
    puts '|    - -    |'
    puts '|           |'
    puts ' ----------- '
  end
end

module Displayable
   def welcome_message
    clear_screen
    puts 'Welcome to TWENTY-ONE!'
  end

  def clear_screen
    system 'clear'
  end

  def line_break
    puts ''
  end

  def display_shuffling_message
    line_break
    puts 'Shuffling and dealing cards...'
    sleep(1)
  end

  def play_again?
    line_break
    puts 'Want to play again? Enter Y if yes, any other key if not.'
    answer = gets.chomp.downcase
    answer == 'y'
  end

  def goodbye_message
    puts 'Thanks for playing twenty-one! Goodbye!'
  end
end  

class Game
  include Displayable

  WINNING_SCORE = 21
  DEALER_MAX = 17

  attr_accessor :human, :dealer, :deck

  def initialize
    @human = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    welcome_message
    human.set_name

    loop do
      deal_cards
      display_cards_gameplay
      play_round
      break unless play_again?
      reset
    end

    goodbye_message
  end

  def play_round
    loop do
      human_turn
      if human.busted?
        busted_outcome
        break
      end

      dealer_turn
      if dealer.busted?
        busted_outcome
        break
      end

      display_winner
      break
    end
  end

  def deal_cards
    display_shuffling_message

    deck.deal!(human)
    deck.deal!(dealer)
  end

  def display_cards_gameplay
    clear_screen

    line_break
    puts "#{human.name}'s cards:"
    human.display_all_cards

    line_break
    puts "#{dealer.name}'s cards"
    dealer.display_one_card

    line_break
    puts "Your current total: #{human.hand_value}"
    line_break
  end

  def display_cards_end
    clear_screen

    line_break
    puts "#{human.name}'s cards:"
    human.display_all_cards

    line_break
    puts "#{dealer.name}'s cards"
    dealer.display_all_cards

    display_final_score
  end

  def display_final_score
    line_break
    puts "#{human.name}'s final score: #{human.hand_value}"
    puts "#{dealer.name}'s final score: #{dealer.hand_value}"
    line_break
  end

  def human_turn
    loop do
      answer = nil
      loop do
        puts 'Would you like to hit or stay?' \
          " Enter 'h' to hit, or enter 's' to stay."
        answer = gets.chomp.downcase
        break if %w(h s).include?(answer)
        puts 'Please enter a valid answer!'
      end
      human.hit_from(deck) if answer == 'h'
      display_cards_gameplay
      break if answer == 's' || human.busted?
    end
  end

  def dealer_turn
    puts "You chose to stay at #{human.hand_value}."
    puts 'Dealers turn!'
    loop do
      sleep(2)
      break if dealer.hand_value >= DEALER_MAX
      dealer.hit_from(deck)
      display_cards_gameplay
      puts "#{dealer.name} hits!"
    end
  end

  def busted_outcome
    display_cards_end
    if human.busted?
      puts 'Sorry, you busted!'
      puts "#{dealer.name} is victorious!"
    elsif dealer.busted?
      puts "#{dealer.name} busted!"
      puts 'Congrats! You are victorious!'
    end
  end

  def display_winner
    puts "#{dealer.name} chooses to stay."
    sleep(2)
    display_cards_end

    human_hand_value = human.hand_value
    dealer_hand_value = dealer.hand_value

    if human_hand_value == dealer_hand_value
      puts 'The final result is a draw!'
    elsif human_hand_value > dealer_hand_value
      puts 'Congratulations! You are victorious!'
    elsif human_hand_value < dealer_hand_value
      puts 'Awww, the dealer won - better luck next time!'
    end
  end

  def reset
    self.deck = Deck.new
    human.hand = []
    dealer.hand = []
  end
end

Game.new.start
