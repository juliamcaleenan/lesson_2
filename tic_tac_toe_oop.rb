class Square
  attr_accessor :position, :value

  def initialize(position, value)
    @position = position
    @value = value
  end

end

class Board
  attr_accessor :squares

  def initialize
    @squares = []
    (1..9).each { |position| @squares << Square.new(position, " ") } 
  end

  def display_board
    system "clear"
    puts "     |     |     "
    puts "  #{squares[0].value}  |  #{squares[1].value}  |  #{squares[2].value}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{squares[3].value}  |  #{squares[4].value}  |  #{squares[5].value}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{squares[6].value}  |  #{squares[7].value}  |  #{squares[8].value}  "
    puts "     |     |     "
  end

end

class Player
  attr_accessor :name, :marker, :choice

  def initialize(name, marker)
    @name = name
    @marker = marker
    @choice = nil
  end

end

class Human < Player

  def choose(squares)
    begin 
      puts "Choose a position (from 1 to 9) to place a piece:"
      @choice = gets.chomp
    end until ((1..9).include?(choice.to_i)) && (squares[choice.to_i - 1].value == " ")
    squares[choice.to_i - 1].value = marker
  end

end

class Computer < Player

  def choose(squares)
    @choice = squares.select { |square| square.value == " " }.sample
    choice.value = marker
  end

end

class TicTacToe
  attr_accessor :human, :computer, :board

  WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  def initialize
    @human = Human.new("Bob", "X")
    @computer = Computer.new("Mac", "O")
    @board = Board.new
  end

  def has_won?(marker)
    arr = board.squares.select { |square| square.value == marker }.map! { |square| square.position }
    permutations = arr.permutation(3).to_a
    permutations.each { |x| return "yes" if WINNING_COMBINATIONS.include?(x) }
  end

  def winning_message(winning_player)
    board.display_board
    puts "#{winning_player.name} has won!"
  end

  def is_tie?
    board.squares.select { |square| square.value == " " }.length == 0
  end

  def tie_message
    board.display_board
    puts "It's a tie!"
  end

  def run
    loop do 
      board.display_board
      human.choose(board.squares)
      if has_won?(human.marker) == "yes"
        winning_message(human)
        break
      end
      if is_tie?
        tie_message
        break
      end
      computer.choose(board.squares)
      if has_won?(computer.marker) == "yes"
        winning_message(computer)
        break
      end
    end
  end

end

TicTacToe.new.run


