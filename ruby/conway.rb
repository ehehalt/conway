#!/usr/bin/env ruby

# Conway Game of Life

# Grid class use a 1D array to simulate 2D matrix
class Grid

  attr_reader :width, :height
  
  def initialize(width=9, height=9)
    @width = width
    @height = height
    @cells = Array.new(@width * @height, 0)
    @alive_symbol = "*"
    @dead_symbol = " "
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
        s += get(row, column) > 0 ? @alive_symbol : @dead_symbol
      end
      s += "\n"
    end
    s
  end

  def is_alive(x,y)
    get(x,y) > 0
  end

  def get_neighbors(row, column)
    count = 0
    (-1..1).each do | delta_row |
      (-1..1).each do | delta_column |
        unless delta_row == 0 and delta_column == 0
          current_row = row + delta_row
          current_column = column + delta_column
          count += 1 if is_alive(current_row, current_column)
        end
      end
    end
    count
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

  attr_reader :grid

  def initialize(width=9, heigh=9)
    @grid = Grid.new(width, heigh)
  end

  def step()
    new_grid = Grid.new(grid.width, grid.height)
    (0...grid.width).each do | row |
      (0...grid.height).each do | column |
        neighbors = grid.get_neighbors(row, column)
        if grid.is_alive(row, column)
          if neighbors >= 2 and neighbors <= 3
            new_grid.set(row, column, 1)
          end
        else
          if neighbors == 3
            new_grid.set(row, column, 1)
          end
        end
      end
    end
    @grid = new_grid
  end
end

game = Game.new(8,8)

# set a glider
game.grid.set(0,0,1)
game.grid.set(1,1,1)
game.grid.set(2,1,1)
game.grid.set(0,2,1)
game.grid.set(1,2,1)

# play conway
while true
  system("clear")
  puts "Conway's Game on a #{game.grid.width}x#{game.grid.height} board:"
  puts
  puts game.grid.to_s
  game.step
  sleep(0.1)
end

