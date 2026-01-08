-module(challenge).
-export([maxScoreWithOneReset/1]).

maxScoreWithOneReset(Nums) ->
    ResetPos = find_min_pos(Nums),
    FinalSum = sum_with_reset(Nums, ResetPos),
    max(FinalSum, 0).

find_min_pos(Nums) ->
    find_min_pos(Nums, 0, 0, 0, 0).

find_min_pos([], _Index, _RunningSum, _MinSum, MinPos) ->
    MinPos;

find_min_pos([H | T], Index, RunningSum, MinSum, MinPos) ->
    NewSum = RunningSum + H,
    case NewSum < MinSum of
        true  ->
            find_min_pos(T, Index + 1, NewSum, NewSum, Index + 1);
        false ->
            find_min_pos(T, Index + 1, NewSum, MinSum, MinPos)
    end.

sum_with_reset(Nums, ResetPos) ->
    sum_with_reset(Nums, 0, 0, ResetPos).

sum_with_reset([], _Index, Acc, _ResetPos) ->
    Acc;

sum_with_reset([H | T], Index, Acc, ResetPos) ->
    NewAcc =
        case Index == ResetPos of
            true  -> H;
            false -> Acc + H
        end,
    sum_with_reset(T, Index + 1, NewAcc, ResetPos).
