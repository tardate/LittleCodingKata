# #xxx minSwapsToAlternate

Using Clojure to find the minimum swaps required to create an alternating array; cassidoo's interview question of the week (2026-03-09).

## Notes

The [interview question of the week (2026-03-09)](https://buttondown.com/cassidoo/archive/u1f312-dont-let-anyone-rob-you-of-your/)
to find the minimum swaps required to create an alternating array:

> Given a string s consisting only of 'a' and 'b', you may swap adjacent characters any number of times. Return the minimum number of adjacent swaps needed to transform s into an alternating string, either "ababab..." or "bababa...", or return -1 if it's impossible.
>
> Example:
>
> ```ts
> minSwapsToAlternate('aabb')
> 1
>
> minSwapsToAlternate('aaab')
> -1
>
> minSwapsToAlternate('aaaabbbb')
> 6
> ```

## Thinking about the Problem

Let:

* `na = count('a')`
* `nb = count('b')`

If `|na - nb| > 1` then a solution is impossible.

Possible solutions:

* start with a: "aba...", or
* start with b: "bab..."

But both are only valid if `na == nb`,

* if `na == nb + 1`, then must start with `a`
* if `nb == na + 1`, then must start with `b`

## A first approach

We don't need to actually perform swaps, just compute how far characters must move:
the number of swaps required is the sum of the distances of characters from the current to required position.

I'm doing this in Clojure and it turns out to be quite elegant.

See source [src/challenge.clj](src/challenge.clj); there are no dependencies required:

```clojure
(ns challenge
  (:gen-class))

(defn min-swaps-to-alternate [s]
  (let [n (count s)
        a-pos (keep-indexed #(when (= %2 \a) %1) s)
        na (count a-pos)
        nb (- n na)
        cost (fn [start]
               (reduce + (map #(Math/abs (- %1 %2))
                              a-pos
                              (range start (* 2 na) 2))))]
    (cond
      (> (Math/abs (- na nb)) 1) -1
      (> na nb) (cost 0)
      (> nb na) (cost 1)
      :else (min (cost 0) (cost 1)))))

(defn -main [& args]
  (let [s (first args)]
    (println (min-swaps-to-alternate s))))
```

Explaining the code:

* starts by calculating the number of characters in the string, the number of `a` and `b`, and the list of current positions of `a`
* core logic is in the `cost` helper:
    * given the `start` position for the first `a`
    * generates the target positions with `range`
    * uses `map` to compute, for each current position of `a`, the absolute distance to its intended position.
* `cond` decision logic used to branch for:
    * impossible case
    * where more `a` than `b`
    * where more `b` than `a`
    * equal numbers of `a` and `b` (uses the `min` cost)

And the result is as expected:

```sh
$ clj -M -m challenge aabb
1
$ clj -M -m challenge aaab
-1
$ clj -M -m challenge aaaabbbb
6
$ clj -M -m challenge aaaabbbbbbaa
9
```

## Credits and References

* [cassidoo's interview question of the week (2026-03-09)](https://buttondown.com/cassidoo/archive/u1f312-dont-let-anyone-rob-you-of-your/)
* [LCK#399 About Clojure](../about/)
* ["1864. Minimum Number of Swaps to Make the Binary String Alternating" - LeetCode](https://github.com/doocs/leetcode/blob/main/solution/1800-1899/1864.Minimum%20Number%20of%20Swaps%20to%20Make%20the%20Binary%20String%20Alternating/README_EN.md)
