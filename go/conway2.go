package main

import "fmt"

type pos struct {
	x int
	y int
}

type board map[pos]bool

const (
	width  = 10
	height = 10
)

var (
	glider = board{pos{4, 2}: true, pos{2, 3}: true, pos{4, 3}: true, pos{3, 4}: true, pos{4, 4}: true}
)

func (b board) show() {
	for y := 1; y < height; y++ {
		for x := 1; x < width; x++ {
			if b[pos{x, y}] {
				fmt.Print("* ")
			} else {
				fmt.Print("  ")
			}
		}
		fmt.Println("")
	}
}

func main() {
	fmt.Println("Hello World")
	glider.show()
}
