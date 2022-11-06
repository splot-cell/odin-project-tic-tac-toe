#frozen_string_literal: true

require_relative "board"

class TicTacToe
  def initialize(board = Board.new)
    @board = board
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
