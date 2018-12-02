#!/usr/bin/env ruby

# Conway Game of Life

# Grid class use a 1D array to simulate 2D matrix
class Grid

  attr_reader :width, :height
  
  def initialize(width=9, height=9)
    @width = width
    @height = height
    @cells = Array.new(@width * @height, 0)
  end

  def get(x,y)
    @cells[idx(x,y)]
  end

  def set(x,y,value)
    @cells[idx(x,y)] = value
  end

  def to_s
    s = ""
    (0...height).each do | row |
      s += "#{row}: "
      (0...width).each do | column |
        s += "#{get(row, column)} "
      end
      s += "\n"
    end
    s
  end

private

  # First version of idx use overflow hard coded,
  # not configurable
  def idx(x, y)
    tx = x % @width
    ty = y % @height
    idx = tx + ty * @width
  end

end

class Game

  def initialize(width=9, heigh=9)
    @grid = Grid.new(width, heigh)
  end

  def width
    @grid.width
  end

  def height
    @grid.height
  end
  
end

grid = Grid.new(8,8)
grid.set(1,1,1)
puts grid.to_s
