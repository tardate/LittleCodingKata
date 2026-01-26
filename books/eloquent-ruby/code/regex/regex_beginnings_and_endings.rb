#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
def introduction
  introduction = /Once upon a time/

  introduction.match?("Oho! Once upon a time a jabberwocky...")
end

def introduction_anchored
  introduction = /\AOnce upon a time/

  introduction.match?("Once upon a time a jabberwocky...")
end

def ending
  ending = /and they all lived happily ever after\.\z/

  ending.match?("Something something and they all lived happily ever after.")
end

def fairytale_content
  fairytale_content = <<~TEXT
    The Princess And The Monkey

    Once upon a time there was a princess...
    ...and they all lived happily ever after.
  TEXT
end

def multiline_fairytale
  fairytale_content.match?(/^Once upon a time/)

  fairytale_content.match?(/happily ever after\.$/)

  fairytale_content.match?(/^Once upon a time/) &&
    fairytale_content.match?(/happily ever after\.$/)
end

def will_not_match_multiline
  match_content = /^Once upon a time.*happily ever after\.$/

  match_content.match?(fairytale_content)
end

def will_match_multiline
  match_content = /^Once upon a time.*happily ever after\.$/m

  match_content.match?(fairytale_content)
end

def start_with_regex
  "Once upon a time".start_with?(/Once/)
end

def start_and_end_with_string
  "Once upon a time".start_with?("Once")
  "happily ever after.".end_with?("after.")

  "Once upon a time".start_with?("Once") &&
    "happily ever after.".end_with?("after.")
end
