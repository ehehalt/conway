package main

import (
	"fmt"
	"os"
	"os/exec"
	"time"
)

// Grid is a 2D slice
type Grid struct {
	Width  int
	Height int
	Cells  []int
}

// NewGrid creates a Grid
func NewGrid(width int, height int) Grid {
	grid := &Grid{Width: width, Height: height}
	size := width * height
	grid.Cells = make([]int, size, size)
	return *grid
}

// Get returns the content of the cell at position x and y
func (grid Grid) Get(x int, y int) int {
	return grid.Cells[grid.Idx(x, y)]
}

// Set sets a value at the position x and y
func (grid *Grid) Set(x int, y int, value int) {
	grid.Cells[grid.Idx(x, y)] = value
}

// Idx returns an idx for a x and y position in the grid
func (grid Grid) Idx(x int, y int) int {
	if x < 0 {
		return grid.Idx(grid.Width+x, y)
	} else if y < 0 {
		return grid.Idx(x, grid.Height+y)
	} else {
		tx := x % grid.Width
		ty := y % grid.Height
		idx := tx + ty*grid.Width
		return idx
	}
}

// String implements the Stringer interface to print out the grid
func (grid Grid) String() string {
	s := ""
	for y := 0; y < grid.Height; y++ {
		s += fmt.Sprintf("%d: ", y)
		for x := 0; x < grid.Width; x++ {
			if grid.Get(x, y) == 0 {
				s += " "
			} else {
				s += "*"
			}
		}
		s += "\n"
	}
	return s
}

// IsAlive checks if the cell at position x and y has a value > 0
func (grid Grid) IsAlive(x int, y int) bool {
	idx := grid.Idx(x, y)
	if grid.Cells[idx] > 0 {
		return true
	}
	return false
}

// GetNeighbors counts the neighbors withh a value > 0
func (grid Grid) GetNeighbors(x int, y int) int {
	count := 0
	for dy := -1; dy <= 1; dy++ {
		for dx := -1; dx <= 1; dx++ {
			if dx == 0 && dy == 0 {
				continue
			}
			if grid.IsAlive(x+dx, y+dy) {
				count++
			}
		}
	}
	return count
}

// Game lets us play conway game of life
type Game struct {
	Grid Grid
}

// NewGame creates a game with a size of width * height
func NewGame(width int, height int) Game {
	grid := NewGrid(width, height)
	game := &Game{Grid: grid}
	return *game
}

// Step calculates the cells for one game step
func (game *Game) Step() {
	var newGrid = NewGrid(game.Grid.Width, game.Grid.Height)
	for y := 0; y < game.Grid.Height; y++ {
		for x := 0; x < game.Grid.Width; x++ {
			var neighbors = game.Grid.GetNeighbors(x, y)
			if game.Grid.IsAlive(x, y) {
				if neighbors >= 2 && neighbors <= 3 {
					newGrid.Set(x, y, 1)
				}
			} else {
				if neighbors == 3 {
					newGrid.Set(x, y, 1)
				}
			}
		}
	}
	game.Grid.Cells = newGrid.Cells
}

func play() {
	game := NewGame(8, 8)

	// set a glider
	game.Grid.Set(0, 0, 1)
	game.Grid.Set(1, 1, 1)
	game.Grid.Set(2, 1, 1)
	game.Grid.Set(0, 2, 1)
	game.Grid.Set(1, 2, 1)

	// play conway
	for true {
		// Clear screen
		c := exec.Command("clear")
		c.Stdout = os.Stdout
		c.Run()

		fmt.Printf("Conway's Game on a %dx%d board:\n\n", game.Grid.Width, game.Grid.Height)
		fmt.Println(game.Grid)
		game.Step()
		time.Sleep(100 * time.Millisecond)
	}
}

func benchmark(loops int) {
	game := NewGame(100, 100)

	// set a glider
	game.Grid.Set(0, 0, 1)
	game.Grid.Set(1, 1, 1)
	game.Grid.Set(2, 1, 1)
	game.Grid.Set(0, 2, 1)
	game.Grid.Set(1, 2, 1)

	for idx := 0; idx < loops; idx++ {
		game.Step()
	}
}

func main() {
	// play()
	benchmark(1000)
}
