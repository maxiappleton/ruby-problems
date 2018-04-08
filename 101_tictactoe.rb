# Tic Tac Toe

# Constants

EMPTY_SPACE = " ".freeze
PLAYER_MARKER = "X".freeze
COMPUTER_MARKER = "O".freeze

# Choices are 'choose', 'player', and 'computer'

FIRST_PLAYER = "choose".freeze

WINNING_POSSIBILITIES =
  [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ].freeze

# Methods

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize, Metrics/LineLength, Metrics/MethodLength
def display_board(brd, score)
  system 'clear'
  puts ""
  puts ""
  puts "        You are #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts "        First player to 5 wins!"
  puts ""
  puts "        Player victories: #{score[:player]}. Computer victories: #{score[:computer]}."
  puts ""
  puts ""
  puts "        (1)      |(2)      |(3)       "
  puts "                 |         |          "
  puts "            #{brd[1]}    |    #{brd[2]}    |    #{brd[3]}     "
  puts "                 |         |          "
  puts "                 |         |          "
  puts "        ---------|---------|--------- "
  puts "        (4)      |(5)      |(6)       "
  puts "                 |         |          "
  puts "            #{brd[4]}    |    #{brd[5]}    |    #{brd[6]}     "
  puts "                 |         |          "
  puts "                 |         |          "
  puts "        ---------|---------|--------- "
  puts "        (7)      |(8)      |(9)       "
  puts "                 |         |          "
  puts "            #{brd[7]}    |    #{brd[8]}    |    #{brd[9]}     "
  puts "                 |         |          "
  puts "                 |         |          "
  puts ""
  puts ""
end
# rubocop:enable Metrics/AbcSize, Metrics/LineLength, Metrics/MethodLength

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = EMPTY_SPACE }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == EMPTY_SPACE }
end

def choose_first_player
  answer = nil
  loop do
    prompt "Who would you like to move first?"
    prompt "Enter 'p' for player, enter 'c' for computer: "
    answer = gets.chomp.downcase
    if (answer == 'p') || (answer == 'c')
      break
    else
      prompt "Please enter a valid choice!"
    end
  end
  return 'player' if answer == 'p'
  return 'computer' if answer == 'c'
end

def player_places_piece!(brd)
  square = nil
  loop do
    prompt "Choose an available square #{empty_squares(brd)}:"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "That's not a valid empty space! Try again."
  end
  brd[square] = PLAYER_MARKER
end

# rubocop:disable Metrics/LineLength
def find_at_risk_square(board, marker)
  WINNING_POSSIBILITIES.each do |opt|
    if board.values_at(*opt).count(marker) == 2
      return board.select { |k, v| opt.include?(k) && v == EMPTY_SPACE }.keys.pop
    end
  end
  nil
end
# rubocop:enable Metrics/LineLength

def computer_places_piece!(brd)
  square = find_square_offence(brd)
  square = find_square_defence(brd) if !square
  square = 5 if !square && (brd[5] == EMPTY_SPACE)
  square = empty_squares(brd).sample if !square

  brd[square] = COMPUTER_MARKER
end

def find_square_offence(brd)
  find_at_risk_square(brd, COMPUTER_MARKER)
end

def find_square_defence(brd)
  find_at_risk_square(brd, PLAYER_MARKER)
end

def place_piece!(brd, current_player)
  player_places_piece!(brd) if current_player == 'player'
  computer_places_piece!(brd) if current_player == 'computer'
end

def alternate_player(current_player)
  return 'computer' if current_player == 'player'
  return 'player' if current_player == 'computer'
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_POSSIBILITIES.each do |opt|
    if brd.values_at(opt[0], opt[1], opt[2]).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(opt[0], opt[1], opt[2]).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def update_score!(scre, brd)
  if detect_winner(brd) == 'Player'
    scre[:player] += 1
  elsif detect_winner(brd) == 'Computer'
    scre[:computer] += 1
  end
end

# Main Program
# rubocop:disable Metrics/BlockLength
loop do
  score = { player: 0, computer: 0 }

  loop do
    board = initialize_board
    display_board(board, score)
    current_player = FIRST_PLAYER
    current_player = choose_first_player if current_player == 'choose'

    loop do
      display_board(board, score)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board, score)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won!"
    else
      prompt "It's a tie!"
    end

    update_score!(score, board)
    break if score[:player] == 5 || score[:computer] == 5
    sleep(2)
  end

  display_board(board, score)
  # rubocop:disable Metrics/LineLength
  prompt "You are the champion! Congratulations!" if score[:player] == 5
  prompt "Awww, better keep practicing, you'll get 'em next time!" if score[:computer] == 5
  prompt "Want to play again? Enter Y if yes, any other key if not."
  break unless gets.chomp.downcase.start_with?('y')
end
# rubocop:enable Metrics/LineLength
prompt "Thank you for playing!"
# rubocop:enable Metrics/BlockLength
