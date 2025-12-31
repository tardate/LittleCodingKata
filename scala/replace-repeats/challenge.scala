//> using scala 3.7.4

def replaceRepeats(s: String, n: Int): String = {
  val target = n.toString.head

  s.foldLeft(List.empty[(Char, Int)]) {
    case ((c, count) :: rest, ch) if ch == c =>
      (c, count + 1) :: rest
    case (acc, ch) =>
      (ch, 1) :: acc
  }.reverse.map {
    case (c, count) if c == target =>
      count.toString
    case (c, count) =>
      c.toString * count
  }
  .mkString
}


def trial(s: String, n: Int, expected: String) = {
  val result = replaceRepeats(s, n)
  print("replaceRepeats(\"" + s + "\", " + n + "): " + result + " ")
  if(result == expected) {
    println("(√CORRECT)")
  } else {
    println("(WRONG, should be " + expected + ")")
  }
}


@main
def hello(): Unit =
  trial("1234500362000440", 0, "1234523623441")
  trial("000000000000", 0, "12")
  trial("123456789", 1, "123456789")
