# Create board
# Print instructions
# Begin LOOP
#   Ask for P1 input (Use P1/P2 toggle)
#   Check for duplicated move
#   Check for win
#   Check if board is full -> DRAW
#   Print updated board
#   Ask for P2 input
#   Check for duplicated move
#   Check for win
#   Print updated board
# END loop

# Game class
# Contains program flow data for interacting with board object

class Board
  WINNING_SEQUENCES = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ].freeze

  def initialize
    @cells = Array.new(9, " ")
    @available_moves = Array.new(9) { |i| i + 1 }
    @next_symbol = "X"
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

  def check_for_win
    WINNING_SEQUENCES.each do |sequence|
      if (@cells[sequence[0]] == @cells[sequence[1]]) &&
         (@cells[sequence[0]] == @cells[sequence[2]]) &&
         (@cells[sequence[0]] != " ")
        return true
      end
    end
    false
  end

  def to_s
    "#{@cells[0]} | #{@cells[1]} | #{@cells[2]}\n" \
    "---------\n" \
    "#{@cells[3]} | #{@cells[4]} | #{@cells[5]}\n" \
    "---------\n" \
    "#{@cells[6]} | #{@cells[7]} | #{@cells[8]}"
  end
end
