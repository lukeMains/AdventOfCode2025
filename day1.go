package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	size := 100
	nums := make([]int, size)
	for i := range size {
		nums[i] = i
	}

	data, err := os.ReadFile("./day-1.input")
	if err != nil {
		fmt.Printf("Error %v\n", err)
		os.Exit(1)
	}

	lines := strings.Split(string(data), "\n")

	fmt.Printf("Nums: [%v..%v]\n", nums[0], nums[len(nums)-1])
	for _, line := range lines[0:] {
		fmt.Println(line)
	}
}
