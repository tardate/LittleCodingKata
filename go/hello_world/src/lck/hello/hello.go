package main

import (
  "fmt"
  "lck/stringthings"
)

func main() {
  message := "Hola Mundo"
  fmt.Println(message)
  fmt.Println(stringthings.Reverse(message))
}
