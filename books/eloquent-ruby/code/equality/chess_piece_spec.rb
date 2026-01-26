#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "chess_piece"

shared_examples "chess pieces" do |clz|
  let(:king) { clz.new(:king) }
  let(:queen) { clz.new(:queen) }
  let(:rook) { clz.new(:rook) }
  let(:bishop) { clz.new(:bishop) }
  let(:knight) { clz.new(:knight) }
  let(:pawn) { clz.new(:pawn) }

  it "orders the pieces properly" do
    expect(king  <=> king).to eq(0)
    expect(king  <=> queen).to eq(1)
    expect(queen <=> king).to eq(-1)

    expect(rook  <=> rook).to eq(0)
    expect(rook  <=> pawn).to eq(1)
    expect(queen <=> rook).to eq(1)
    expect(rook  <=> queen).to eq(-1)

    expect(knight <=> bishop).to eq(0)

    expect(pawn  <=> pawn).to eq(0)
    expect(king  <=> pawn).to eq(1)
    expect(knight <=> pawn).to eq(1)
    expect(pawn   <=> knight).to eq(-1)
  end
end

describe Basic::ChessPiece do
  include_examples "chess pieces", Basic::ChessPiece
end

describe Better::ChessPiece do
  include_examples "chess pieces", Better::ChessPiece
end

