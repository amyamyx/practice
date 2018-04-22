require 'byebug'
require_relative 'card'
class Board

  attr_accessor :grid

  def self.empty_grid
    empty_grid = Array.new(4) {Array.new(5)}
    Board.new(empty_grid)
  end

  def initialize(grid)
    @grid = grid
  end

  def populate

    cards = []

    10.times do |i|
      cards << Card.new(i)
      cards << Card.new(i)
    end
    cards.shuffle!

    @grid.map! do |row|
      row.map! do |el|
        cards.shift
      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def render
    rows = ["0 | ", "1 | ", "2 | ", "3 | "]
    @grid.each_with_index do |row, i|
      row.each do |el|
        rows[i].concat("#{el.to_s} | ")
      end
    end

    puts "    0   1   2   3   4"
    puts "  ---------------------"
    rows.each do |row|
      puts row
      puts "  ---------------------"
    end
  end

  def won?
    @grid.all? do |row|
      row.all? { |card| card.face_up }
    end
  end

  def reveal(pos)
    row, col = pos
    @grid[row][col].reveal
  end

end
