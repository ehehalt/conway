//
//  main.swift
//  Conway
//
//  Created by Michael Ehehalt on 03.12.18.
//  Copyright © 2018 Michael Ehehalt. All rights reserved.
//

import Foundation

class Grid : CustomStringConvertible {
  var width : Int
  var height : Int
  var cells : [Int]
  
  init(width: Int, height: Int) {
    self.width = width
    self.height = height
    self.cells = [Int](repeating: 0, count: width * height)
  }
  
  func get(x: Int, y: Int) -> Int {
    return cells[idx(x: x, y: y)]
  }
  
  func set(x: Int, y: Int, value: Int) {
    let pos = idx(x: x, y: y)
    cells[pos] = value
  }
  
  func idx(x: Int, y: Int) -> Int {
    if x < 0 {
      return idx(x: self.width+x, y: y)
    } else if y < 0 {
      return idx(x: x, y: self.height+y)
    } else {
      let tx = x % self.width
      let ty = y % self.height
      let pos = tx + ty * self.width
      return pos
    }
  }

  var description: String {
    var s = ""
    for y in 0..<height {
      s += "\(y): "
      for x in 0..<width {
        s += get(x: x, y: y) > 0 ? "*" : " "
      }
      s += "\n"
    }
    return s
  }
  
  func isAlive(x: Int, y: Int) -> Bool {
    return get(x: x, y: y) > 0
  }
  
  func getNeighbors(x: Int, y: Int) -> Int {
    var count = 0
    for deltaRow in -1...1 {
      for deltaCol in -1...1 {
        if deltaRow == 0 && deltaCol == 0 {
          continue
        }
        let row = y + deltaRow
        let col = x + deltaCol
        if isAlive(x: col, y: row) {
          count += 1
        }
      }
    }
    return count
  }
}

class Game {
  var grid : Grid
  
  init(width: Int, height: Int) {
    grid = Grid(width: width, height: height)
  }
  
  func step() {
    let newGrid = Grid(width: grid.width, height: grid.height)
    for row in 0..<grid.height {
      for col in 0..<grid.width {
        let neighbors = grid.getNeighbors(x: col, y: row)
        if grid.isAlive(x: col, y: row) {
          if neighbors >= 2 && neighbors <= 3 {
            newGrid.set(x: col, y: row, value: 1)
          }
        } else {
          if neighbors == 3 {
            newGrid.set(x: col, y: row, value: 1)
          }
        }
      }
    }
    grid = newGrid
  }
}

func play() {
  let game = Game(width: 8, height: 8)
  
  // set a glider
  game.grid.set(x: 0, y: 0, value: 1)
  game.grid.set(x: 1, y: 1, value: 1)
  game.grid.set(x: 2, y: 1, value: 1)
  game.grid.set(x: 0, y: 2, value: 1)
  game.grid.set(x: 1, y: 2, value: 1)

  // play conway
  while true {
    print("\u{001B}[2J")
    print("Conway's Game on a \(game.grid.width)x\(game.grid.height) board:")
    print("")
    print(game.grid)
    game.step()
    usleep(100000)
  }
}

func benchmark() {
  let game = Game(width: 100, height: 100)
  
  // set a glider
  game.grid.set(x: 0, y: 0, value: 1)
  game.grid.set(x: 1, y: 1, value: 1)
  game.grid.set(x: 2, y: 1, value: 1)
  game.grid.set(x: 0, y: 2, value: 1)
  game.grid.set(x: 1, y: 2, value: 1)
  
  // play conway
  for _ in 0..<1000 {
    game.step()
  }
}

benchmark()
