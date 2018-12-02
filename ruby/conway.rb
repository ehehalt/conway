#!/usr/bin/env ruby

# Conway Game of Life

class Grid

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

private
  
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

