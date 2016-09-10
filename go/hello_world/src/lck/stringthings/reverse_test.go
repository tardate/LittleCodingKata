package stringthings

import "testing"

func TestReverse(t *testing.T) {
  cases := []struct {
    given, expect string
  }{
    {"Hello, world", "dlrow ,olleH"},
    {"Hello, 世界", "界世 ,olleH"},
    {"", ""},
  }
  for _, c := range cases {
    got := Reverse(c.given)
    if got != c.expect {
      t.Errorf("Reverse(%q) == %q, want %q", c.given, got, c.expect)
    }
  }
}