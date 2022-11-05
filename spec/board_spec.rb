# frozen_string_literal: true

require_relative "../lib/tic_tac_toe"

describe Board do
  subject(:board_init) { described_class.new }

  describe "#move" do
    context "when the position is valid" do
      before do
        allow(board_init).to receive(:toggle_next_symbol)
      end

      it "updates @cells with position" do
        valid_pos = 5
        old_cells = Array.new(9, " ")
        new_cells = [" ", " ", " ", " ", "X", " ", " ", " ", " "]
        expect { board_init.move(valid_pos) }.to change { board_init.instance_variable_get(:@cells) }.from(old_cells).to(new_cells)
      end

      it "removes the position from @available_moves" do
        valid_pos = 7
        old_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        new_moves = [1, 2, 3, 4, 5, 6, 8, 9]
        expect { board_init.move(valid_pos) }.to change { board_init.instance_variable_get(:@available_moves) }.from(old_moves).to(new_moves)
      end

      context "when it is 'O's move" do
        before do
          cells = [" ", " ", " ", " ", "X", " ", " ", " ", " "]
          board_init.instance_variable_set(:@next_symbol, "O")
          board_init.instance_variable_set(:@cells, cells)
        end

        it "updates the @cells with '0'" do
          valid_pos = 1
          old_cells = [" ", " ", " ", " ", "X", " ", " ", " ", " "]
          new_cells = ["O", " ", " ", " ", "X", " ", " ", " ", " "]
          expect { board_init.move(valid_pos) }.to change { board_init.instance_variable_get(:@cells) }.from(old_cells).to(new_cells)
        end
      end
    end

    context "when the position is invalid" do
      before do
        board_init.move(5)
        allow(board_init).to receive(:toggle_next_symbol)
      end

      it "does not update @cells" do
        invalid_pos = 5
        expect { board_init.move(invalid_pos) }.not_to change { board_init.instance_variable_get(:@cells) }
      end

      it "does not update @available_moves" do
        invalid_pos = 5
        expect { board_init.move(invalid_pos) }.not_to change { board_init.instance_variable_get(:@available_moves) }
      end
    end
  end

  describe "#check_for_winner" do
    context "when the Board is initialized" do
      it "returns nil" do
        expect(board_init.check_for_winner).to be(nil)
      end
    end

    context "when there is no winner" do
      subject(:board_no_win) { described_class.new }

      before do
        no_winning_positions = %w[X O X O X X O X O]
        board_no_win.instance_variable_set(:@cells, no_winning_positions)
      end

      it "returns nil" do
        expect(board_no_win.check_for_winner).to be_nil
      end
    end

    context "when 'X' has won" do
      subject(:board_x_win) { described_class.new }

      context "across top row" do
        it "returns 'X'" do
          winning_positions = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
          board_x_win.instance_variable_set(:@cells, winning_positions)
          expect(board_x_win.check_for_winner).to be("X")
        end
      end

      context "across bottom row" do
        it "returns 'X'" do
          winning_positions = [" ", " ", " ", " ", " ", " ", "X", "X", "X"]
          board_x_win.instance_variable_set(:@cells, winning_positions)
          expect(board_x_win.check_for_winner).to be("X")
        end
      end

      context "down left column" do
        it "returns 'X'" do
          winning_positions = [" ", " ", "X", " ", " ", "X", " ", " ", "X"]
          board_x_win.instance_variable_set(:@cells, winning_positions)
          expect(board_x_win.check_for_winner).to be("X")
        end
      end

      context "down right column" do
        it "returns 'X'" do
          winning_positions = [" ", "O", "X", "O", " ", "X", "O", " ", "X"]
          board_x_win.instance_variable_set(:@cells, winning_positions)
          expect(board_x_win.check_for_winner).to be("X")
        end
      end

      context "diagonal right and down" do
        it "returns 'X'" do
          winning_positions = ["X", " ", " ", " ", "X", "O", "O", "O", "X"]
          board_x_win.instance_variable_set(:@cells, winning_positions)
          expect(board_x_win.check_for_winner).to be("X")
        end
      end
    end

    context "when 'O' has won" do
      subject(:board_o_win) { described_class.new }

      context "across middle row" do
        it "returns 'O'" do
          winning_positions = [" ", "X", " ", "O", "O", "O", "X", " ", "X"]
          board_o_win.instance_variable_set(:@cells, winning_positions)
          expect(board_o_win.check_for_winner).to be("O")
        end
      end

      context "down middle colum" do
        it "returns 'O'" do
          winning_positions = [" ", "O", " ", "X", "O", " ", "X", "O", "X"]
          board_o_win.instance_variable_set(:@cells, winning_positions)
          expect(board_o_win.check_for_winner).to be("O")
        end
      end

      context "diagonal left and down" do
        it "returns 'O'" do
          winning_positions = [" ", " ", "O", "X", "O", "X", "O", " ", "X"]
          board_o_win.instance_variable_set(:@cells, winning_positions)
          expect(board_o_win.check_for_winner).to be("O")
        end
      end
    end
  end
end
