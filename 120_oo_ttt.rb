# OO Tic Tac Toe

class Board
  WINNING_LINES =
    [
      [1, 2, 3], [4, 5, 6], [7, 8, 9],
      [1, 4, 7], [2, 5, 8], [3, 6, 9],
      [1, 5, 9], [3, 5, 7]
    ].freeze

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize, Metrics/LineLength, Metrics/MethodLength
  def draw
    puts '        (1)      |(2)      |(3)       '
    puts '                 |         |          '
    puts "            #{@squares[1]}    |    #{@squares[2]}    |    #{@squares[3]}     "
    puts '                 |         |          '
    puts '                 |         |          '
    puts '        ---------|---------|--------- '
    puts '        (4)      |(5)      |(6)       '
    puts '                 |         |          '
    puts "            #{@squares[4]}    |    #{@squares[5]}    |    #{@squares[6]}     "
    puts '                 |         |          '
    puts '                 |         |          '
    puts '        ---------|---------|--------- '
    puts '        (7)      |(8)      |(9)       '
    puts '                 |         |          '
    puts "            #{@squares[7]}    |    #{@squares[8]}    |    #{@squares[9]}     "
    puts '                 |         |          '
    puts '                 |         |          '
  end
  # rubocop:enable Metrics/AbcSize, Metrics/LineLength, Metrics/MethodLength

  def unmarked_keys
    @squares.select { |_, sq| sq.unmarked? }.keys
  end

  def full?
    unmarked_keys.empty?
  end

  def winner?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def find_at_risk_square(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if squares.map(&:marker).count(marker) == 2
        at_risk_sq = squares.find { |sq| sq.marker == Square::INITIAL_MARKER }
        return @squares.key(at_risk_sq)
      end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end
end

class Square
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_accessor :score, :marker, :name

  def initialize
    @marker = nil
    @score = 0
  end
end

class Human < Player
  def initialize
    super
    @name = nil
  end

  def set_name
    user_name = ''
    loop do
      puts "Hi There! What's your name?"
      user_name = gets.chomp.capitalize.strip
      break unless user_name.empty?
      puts 'Sorry, you must enter a valid name.'
    end
    self.name = user_name
  end

  def set_marker
    answer = ''
    loop do
      puts "Hi #{@name}! What marker would you like to be? Enter 'X' or 'O':"
      answer = gets.chomp.upcase
      break if %w(X O).include?(answer)
      puts "Sorry, that's not a valid choice!"
    end
    self.marker = answer
  end

  def move(board)
    puts "Please choose a square - #{format_empty_squares(board)}:"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    square
  end

  def format_empty_squares(board)
    squares = board.unmarked_keys
    case squares.size
    when 1
      (squares[0]).to_s
    when 2
      "#{squares[0]} or #{squares[1]}"
    else
      squares[0..-2].join(', ') + ", or #{squares[-1]}"
    end
  end
end

class Computer < Player
  def initialize
    super
    @name = %w(Aido Cortana Viv).sample
  end

  def determine_marker(human_choice)
    self.marker = if human_choice == 'X'
                    'O'
                  else
                    'X'
                  end
  end

  def move(board, human_marker)
    square = board.find_at_risk_square(marker)
    square = board.find_at_risk_square(human_marker) if square.nil?
    square = 5 if square.nil? && board.unmarked_keys.include?(5)
    square = board.unmarked_keys.sample if square.nil?
    square
  end
end

module Displayable
  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
  end

  def clear_screen
    system 'clear'
  end

  def line_break
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def play_again?
    puts ''
    puts 'Want to play again? Enter Y if yes, any other key if not.'
    answer = gets.chomp.downcase
    answer == 'y'
  end
end

# Game engine

class TTTGame
  include Displayable

  ROUNDS_TO_WIN = 2

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @first_to_move = nil
    @current_marker = nil
    @round = 1
  end

  def play
    clear_screen
    display_welcome_message
    human.set_name

    loop do
      choose_markers
      determine_who_starts
      play_rounds
      display_game_winner
      break unless play_again?
      reset_game
    end

    display_goodbye_message
  end

  private

  def choose_markers
    human.set_marker
    computer.determine_marker(human.marker)
  end

  def determine_who_starts
    answer = nil
    loop do
      puts 'Who would you like to move first throughout this game?'
      puts "Enter 'p' for player, enter 'c' for computer: "
      answer = gets.chomp.downcase
      break if %w(p c).include?(answer)
      puts 'Please enter a valid choice!'
    end
    @first_to_move = if answer == 'p'
                       human.marker
                     else
                       computer.marker
                     end

    @current_marker = @first_to_move
  end

  def play_rounds
    loop do
      display_board

      loop do
        current_player_moves
        break if board.winner? || board.full?
        display_board if human_turn?
      end

      display_round_result
      update_scores
      break if game_winner?
      reset_round
    end
  end

  def display_board
    clear_screen
    display_information
    board.draw
    line_break
  end

  def display_information
    line_break
    display_participant_markers
    line_break
    display_round_info
    line_break
    display_score
    line_break
  end

  def display_participant_markers
    puts "        #{human.name} is #{human.marker}.\
    #{computer.name} is #{computer.marker}."
  end

  def display_round_info
    puts "        ROUND #{@round}!"
    puts "        First to #{ROUNDS_TO_WIN} wins is victorious!"
  end

  def display_score
    puts "        Scores - #{human.name}: #{human.score}\
    #{computer.name}: #{computer.score}"
  end

  def current_player_moves
    if human_turn?
      human_move
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def human_move
    square = human.move(board)
    board[square] = human.marker
  end

  def computer_moves
    square = computer.move(board, human.marker)
    board[square] = computer.marker
  end

  def display_round_result
    display_board

    case board.winning_marker
    when human.marker
      puts "Congrats, #{human.name} won this round!"
    when computer.marker
      puts "Awww, #{computer.name} won this round!"
    else
      puts "It's a tie! No winner!"
    end
    sleep(2)
  end

  def update_scores
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def game_winner?
    human.score == ROUNDS_TO_WIN || computer.score == ROUNDS_TO_WIN
  end

  def reset_round
    board.reset
    @current_marker = @first_to_move
    @round += 1
  end

  def display_game_winner
    human_name = human.name
    computer_name = computer.name
    human_score = human.score
    computer_score = computer.score

    clear_screen
    puts ''

    if human.score == ROUNDS_TO_WIN
      puts "#{human_name} IS VICTORIOUS :)! Congrats!"
    else
      puts "Sorry, #{computer_name} is the winner this time :("
    end
    puts ''
    puts "The final score is - #{human_name}: #{human_score},"\
      " #{computer_name}: #{computer_score}."
  end

  def reset_game
    reset_round
    puts "Let's play again!"
    human.score = 0
    computer.score = 0
    @round = 1
  end
end

game = TTTGame.new
game.play
