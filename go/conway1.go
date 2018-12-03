package main

import "fmt"

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
	var tx = x % grid.Width
	var ty = y % grid.Height
	var idx = tx + ty*grid.Width
	return idx
}

func main() {
	fmt.Println("conway")

	grid := NewGrid(10, 10)
	grid.Set(0, 0, 10)
	fmt.Println(grid.Get(0, 0))

}
