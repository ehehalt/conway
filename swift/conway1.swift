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

var grid = Grid(width: 10, height: 10)
grid.set(x: 1, y: 1, value: 1)
grid.set(x: -1, y: -1, value: 1)
print(grid)