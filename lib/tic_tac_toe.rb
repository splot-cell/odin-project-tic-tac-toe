class Board
  WINNING_SEQUENCES = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize(cells = Array.new(9, " "), available_moves = Array.new(9) { |i| i + 1 }, next_symbol = "X")
    @cells
    @available_moves = available_moves
    @next_symbol = next_symbol
  end

  def toggle_next_symbol
    @next_symbol = @next_symbol == "X" ? "O" : "X"
  end

  def reset
    @cells.each_index { |i| @cells[i] = " " }

    @available_moves.clear
    @available_moves = Array.new(9) { |i| i + 1 }

    @next_symbol = "X"
  end

  def move(position)
    return unless @available_moves.include?(position)

    @cells[position - 1] = @next_symbol
    @available_moves.delete(position)
    toggle_next_symbol
  end

  def check_for_winner
    WINNING_SEQUENCES.each do |sequence|
      if (@cells[sequence[0]] == @cells[sequence[1]]) &&
         (@cells[sequence[0]] == @cells[sequence[2]]) &&
         (@cells[sequence[0]] != " ")
        return @cells[sequence[0]]
      end
    end
    nil
  end

  def to_s
    "#{@cells[0]} | #{@cells[1]} | #{@cells[2]}\n" \
    "---------\n" \
    "#{@cells[3]} | #{@cells[4]} | #{@cells[5]}\n" \
    "---------\n" \
    "#{@cells[6]} | #{@cells[7]} | #{@cells[8]}"
  end
end

class TicTacToe
  def initialize
    @board = Board.new
    @winner = " "
    @turn = 0
  end

  def print_instructions
    puts "Make a selection by typing in a cell number:\n\n" \
    "1 | 2 | 3\n" \
    "---------\n" \
    "4 | 5 | 6\n" \
    "---------\n" \
    "7 | 8 | 9\n\n" \
    "First to make a line of three wins!"
  end

  def get_player_input
    print "Make your selection: "
    loop do
      selection = gets.to_i
      if (selection < 1) || (selection > 9)
        puts "Selection out of range!\n" \
        "Make another selection:"
        next
      end

      unless @board.move(selection)
        puts "Invalid selection!\n" \
        "Make another selection:"
        next
      end

      break
    end
  end

  def print_result(winner)
    if winner
      puts "The winner is #{winner}! Well done!"
    else
      puts "It's a draw this time!"
    end
  end

  def game_loop
    while @turn < 9
      get_player_input
      puts "#{@board}\n\n"
      if (winner = @board.check_for_winner)
        return winner
      end

      @turn += 1
    end
  end

  def run_game
    print_instructions
    print_result(game_loop)
  end
end

# game = TicTacToe.new
# game.run_game
