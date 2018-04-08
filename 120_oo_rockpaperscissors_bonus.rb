# OO Rock Paper Scissors

# Display Methods

module Displayable
  ROUNDS_TO_WIN = 3
  HISTORY_MOVES_DISPLAY = 5

  def prompt(msg)
    puts "=> #{msg}"
  end

  def clear_screen
    sleep(2)
    system 'clear'
  end

  def display_welcome_message
    prompt "#{human.name}, welcome to Rock, Paper, Scissors, Lizard, Spock!"
    prompt "First to #{ROUNDS_TO_WIN} wins is victorious!"
  end

  def display_scores
    puts ''
    prompt "First to #{ROUNDS_TO_WIN} wins!"
    prompt "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
  end

  def display_history
    puts ''
    prompt "*** HISTORY OF MOVES (last #{HISTORY_MOVES_DISPLAY} displayed): ***"
    formatted_history(human)
    puts ''
    formatted_history(computer)
  end

  def formatted_history(player)
    player.history.reverse_each.with_index do |array, i|
      if i.zero?
        puts "#{player.name} - last move: #{array[0]} --> RESULT: #{array[1]}"
      elsif i < HISTORY_MOVES_DISPLAY
        puts "#{' ' * (player.name.length + 3)}#{i + 1} moves ago: " \
        "#{array[0]} --> RESULT: #{array[1]}"
      end
    end
  end

  def display_moves
    puts ''
    prompt "#{human.name} chose #{human.move}."
    prompt "#{computer.name} chose #{computer.move}."
  end

  def display_round_result(round_result)
    case round_result
    when 'win'
      prompt "#{human.name} wins this round!"
    when 'loss'
      prompt "Sorry, #{computer.name} won this round!"
    else
      prompt "It's a tie!"
    end
    sleep(1)
  end

  def display_final_scores
    human_name = human.name
    human_score = human.score
    computer_name = computer.name
    computer_score = computer.score

    prompt "Final score this round: #{human_name}: #{human_score}," \
      "#{computer_name}: #{computer_score}"
    if human_score == ROUNDS_TO_WIN
      prompt "#{human_name} is victorious!"
    else
      prompt "#{computer_name} is victorious!"
    end
  end

  def display_all_time_scores
    puts ''
    puts '*** ALL-TIME SCORES ***'
    puts '-----------------------'
    prompt "#{human.name} WINS: #{human.history.flatten.count('win')}"
    prompt "#{computer.name} WINS: #{computer.history.flatten.count('win')}"
    puts '-----------------------'
  end

  def display_goodbye_message
    prompt 'Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good Bye!'
  end
end

# Player Classes

class Player
  include Displayable

  attr_accessor :move, :name, :score, :history

  def initialize
    set_name
    @score = 0
    @history = []
  end
end

class Human < Player
  SHORTCUTS = {
    'r' => 'rock',
    'p' => 'paper',
    'sc' => 'scissors',
    'l' => 'lizard',
    'sp' => 'spock'
  }.freeze

  def set_name
    user_name = ''
    loop do
      prompt "Hi There! What's your name?"
      user_name = gets.chomp.capitalize.strip
      break unless user_name.empty?
      prompt 'Sorry, you must enter a valid name.'
    end
    self.name = user_name
  end

  def choose
    choice = nil
    loop do
      puts ''
      prompt 'Choose one: (r)rock, (p)paper, (sc)scissors, (l)lizard, (sp)spock'
      answer = gets.chomp.downcase
      choice = SHORTCUTS[answer]
      break if Move::VALUES.include?(choice)
      prompt 'Sorry, please enter a valid move.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(Hal Siri Alexa).sample
  end

  # If it loses more than 20% of the time using a move, it avoids that move.
  def twenty_percent_strategy
    losing_percentages = Hash.new(0)
    Move::VALUES.each do |move|
      if history.include?([move, 'loss'])
        total_rounds = history.size.to_f
        num_losses = history.count([move, 'loss'])
        losing_percentages[move] = (num_losses / total_rounds) * 100
      else
        losing_percentages[move] = 0
      end
    end
    choices = losing_percentages.keep_if { |_, percent| percent < 20 }.keys
    self.move = Move.new(choices.sample)
  end

  # It has a higher tendancy to choose lizard and spock.
  def weigh_choices_strategy
    random_num = rand(1..100)
    choice = case random_num
             when 1..10 then 'rock'
             when 11..20 then 'paper'
             when 21..30 then 'scissors'
             when 31..60 then 'lizard'
             when 61..100 then 'spock'
             end
    self.move = Move.new(choice)
  end

  # It panics and chooses only rock when it has more losses than wins
  # but avoids using rock in every other situation.
  def rock_strategy
    losses = history.flatten.count('loss')
    wins = history.flatten.count('win')
    self.move = if losses > wins
                  Move.new('rock')
                else
                  Move.new(%w(paper scissors lizard spock).sample)
                end
  end

  def choose
    if @name == 'Hal'
      twenty_percent_strategy
    elsif @name == 'Siri'
      weigh_choices_strategy
    elsif @name == 'Alexa'
      rock_strategy
    end
  end
end

# Move Class

class Move
  attr_accessor :value

  VALUES = %w(rock paper scissors lizard spock).freeze

  WINNING_POSSIBILITIES = {
    'rock' => %w(scissors lizard),
    'paper' => %w(rock spock),
    'scissors' => %w(paper lizard),
    'lizard' => %w(paper spock),
    'spock' => %w(rock scissors)
  }.freeze

  def initialize(value)
    @value = value
  end

  def >(other_move)
    WINNING_POSSIBILITIES[@value].include?(other_move.value)
  end

  def <(other_move)
    WINNING_POSSIBILITIES[other_move.value].include?(@value)
  end

  def to_s
    @value
  end
end

# Game Engine

class RPSGame
  include Displayable

  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def determine_round_result
    if human.move > computer.move
      'win'
    elsif human.move < computer.move
      'loss'
    else
      'tie'
    end
  end

  def update_history(round_result)
    human.history << [human.move.value, round_result]
    comp_result = case round_result
                  when 'win' then 'loss'
                  when 'loss' then 'win'
                  else 'tie'
                  end
    computer.history << [computer.move.value, comp_result]
  end

  def update_scores(round_result)
    if round_result == 'win'
      human.score += 1
    elsif round_result == 'loss'
      computer.score += 1
    end
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end

  def winner?
    human.score == ROUNDS_TO_WIN || computer.score == ROUNDS_TO_WIN
  end

  def play_again?
    puts ''
    answer = nil
    loop do
      prompt 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if answer == 'y' || answer == 'n'
      prompt "Sorry, please enter 'y' or 'n'"
    end
    answer == 'y'
  end

  def round_play
    loop do
      clear_screen
      display_scores
      display_history
      human.choose
      computer.choose
      display_moves
      round_outcome = determine_round_result
      display_round_result(round_outcome)
      update_scores(round_outcome)
      update_history(round_outcome)
      break if winner?
    end
  end

  def play
    clear_screen
    display_welcome_message

    loop do
      reset_scores
      round_play
      clear_screen
      display_final_scores
      display_all_time_scores
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
