# frozen_string_literal: true

require_relative "../lib/tic_tac_toe"

describe Board do
  subject(:board_init) { described_class.new }

  describe "#check_for_winner" do
    context "when the Board is initialized" do
      it "returns nil" do
        expect(board_init.check_for_winner).to be(nil)
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
          winning_positions = [" ", " ", "X", " ", " ", "X", " ", " ", "X"]
          board_x_win.instance_variable_set(:@cells, winning_positions)
          expect(board_x_win.check_for_winner).to be("X")
        end
      end

      context "diagonal right and down" do
        it "returns 'X'" do
          winning_positions = ["X", " ", " ", " ", "X", " ", " ", " ", "X"]
          board_x_win.instance_variable_set(:@cells, winning_positions)
          expect(board_x_win.check_for_winner).to be("X")
        end
      end
    end
  end
end
