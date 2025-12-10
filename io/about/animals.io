Animal := Object clone
Animal hello := "???"
Animal speak := method(hello println)

Cat := Animal clone
Cat hello = "meow"

Dog := Animal clone
Dog hello = "woof"

pets := list(Cat, Dog)
pets foreach(speak)
