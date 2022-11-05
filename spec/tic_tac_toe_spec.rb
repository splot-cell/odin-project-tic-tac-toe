# frozen_string_literal: true

require_relative "../lib/tic_tac_toe"

describe Board do
  subject(:init_board) { described_class.new }

  describe "#check_for_winner" do
    context "When the Board is initialized" do
      it "Returns nil" do
        expect(init_board.check_for_winner).to be(nil)
      end
    end
  end
end
