# frozen_string_literal: true

require_relative "../lib/tic_tac_toe"

describe TicTacToe do
  let(:board) { double("board") }
  subject(:game_init) { described_class.new(board) }

  describe "#get_player_input" do
    context "when input is valid" do
      before do
        allow(game_init).to receive(:print).with("Make your selection: ")
        allow(game_init).to receive(:gets).and_return(5)
        allow(board).to receive(:move).and_return("O")
      end

      it "calls @board.move once and breaks out of loop" do
        expect(board).to receive(:move).once
        game_init.get_player_input
      end

      it "does not write an error message to console" do
        expect(game_init).not_to receive(:puts)
        game_init.get_player_input
      end
    end

    context "when input is out of range once, then valid" do
      before do
        allow(game_init).to receive(:print).with("Make your selection: ")
        allow(game_init).to receive(:gets).and_return(10, 3)
        allow(board).to receive(:move).and_return("O")
      end

      it "prints the error message" do
        expect(game_init).to receive(:puts).with("Selection out of range!\nMake another selection:").once
        game_init.get_player_input
      end

      it "calls @board.move once" do
        expect(board).to receive(:move).with(3).once
        game_init.get_player_input
      end
    end

    context "when selected position is already taken once, then valid" do
      before do
        allow(game_init).to receive(:print).with("Make your selection: ")
        allow(game_init).to receive(:gets).and_return(3)
        allow(board).to receive(:move).and_return(nil, "X")
        allow(game_init).to receive(:puts)
      end

      it "calls gets twice" do
        expect(game_init).to receive(:gets).twice
        game_init.get_player_input
      end

      it "calls @board.move twice" do
        expect(board).to receive(:move).with(3).twice
        game_init.get_player_input
      end

      it "print the error message once" do
        expect(game_init).to receive(:puts).with("Invalid selection!\nMake another selection:").once
        game_init.get_player_input
      end

      it "prints the selection prompt once" do
        expect(game_init).to receive(:print).with("Make your selection: ").once
        game_init.get_player_input
      end
    end
  end
end
