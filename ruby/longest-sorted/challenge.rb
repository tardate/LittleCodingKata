#!/usr/bin/env ruby

class Challenge
  attr_accessor :sentence

  def initialize(sentence)
    self.sentence = sentence
  end

  def words
    sentence.split.map { |word| word.downcase.gsub(/[^a-z]/, '') }
  end

  def alphabetically_sorted_words
    words.select { |word| word.length > 1 && word == word.chars.sort.join }
  end

  def longestSorted
    alphabetically_sorted_words.max_by { |word| word.length  } || ""
  end
end

if __FILE__ == $PROGRAM_NAME
  (puts "Usage: ruby #{$0} <sentence>"; exit) unless ARGV.length == 1
  sentence = ARGV[0]
  calculator = Challenge.new(sentence)
  puts "Sentence: #{calculator.sentence.inspect}"
  puts "Result: #{calculator.longestSorted.inspect}"
end
