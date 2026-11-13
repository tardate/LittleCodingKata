#!/usr/bin/env ruby
require 'json'

def comebackRound(rounds)
  rounds.reduce(winning_round: -1, round: 0, winner: nil, scores: []) do |result, points|
    result[:scores] = points.zip(result[:scores]).map { |x, y| x + y.to_i }
    max_score = result[:scores].max
    if result[:scores].count(max_score) == 1 # we have a winner
      round_winner = result[:scores].index(max_score)
      if round_winner != result[:winner] # winner has changed
        result[:winner] = round_winner
        result[:winning_round] = result[:round] + 1 # 1-based
      end
    else
      result[:winning_round] = -1
      result[:winner] = nil
    end
    result[:round] += 1
    result
  end[:winning_round]
end

def comebackRoundDualPass(rounds)
  tally = rounds.each_with_object([]) do |points, scores|
    scores << points.zip(scores.last || []).map { |x, y| x + y.to_i }
  end
  winning_round = -1
  winner = nil
  (tally.size - 1).downto(0) do |round|
    scores = tally[round]
    max_score = scores.max
    if scores.count(max_score) == 1 # we have a winner
      round_winner = scores.index(max_score)
      break if winner && round_winner != winner # winner has swapped
      winner = round_winner
      winning_round = round + 1 # 1-based
    else
      break
    end
  end
  winning_round
end

if __FILE__ == $PROGRAM_NAME
  (warn "Usage: ruby #{$0} <json-file> <optional-algorithm>"; exit) unless ARGV.length == 1 || ARGV.length == 2
  json_file_name = ARGV[0]
  begin
    rounds = JSON.parse(File.read(json_file_name))
  rescue
    puts "Error: Invalid JSON file - #{json_file_name}"
    exit
  end
  algorithm = ARGV[1] || 'comebackRound'
  warn "Rounds: #{rounds.inspect}"
  warn "#{algorithm} Result:"
  puts send(algorithm, rounds).inspect
end
