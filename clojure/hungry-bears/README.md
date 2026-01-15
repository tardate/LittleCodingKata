# #402 hungryBears

Using Clojure to find the bears that are more hungry than average; cassidoo's interview question of the week (2026-01-12).

## Notes

The [interview question of the week (2026-01-12)](https://buttondown.com/cassidoo/archive/the-future-is-sending-back-good-wishes-and/)
asks us to find the bears that are more hungry than average:

> Given an array of objects representing bears in a forest, each with a name and hunger level, return the names of all bears whose hunger level is above the forest average, sorted alphabetically. In how few lines can you do this one?
>
> Example:
>
> ```ts
> const bears = [
>   { name: 'Baloo', hunger: 6 },
>   { name: 'Yogi', hunger: 9 },
>   { name: 'Paddington', hunger: 4 },
>   { name: 'Winnie', hunger: 10 },
>   { name: 'Chicago', hunger: 20 },
> ];
>
> hungryBears(bears)
> > ['Chicago', 'Winnie']
> ```

## Thinking about the Problem

There are three elements required of the solution:

* determine the average hunger
* find bears with hunger > average
* sort the bear names

In ruby-ish pseudo-code, this could be a one-line map-reduce type problem:

```pseudocode
bears.select { |bear| bear['hunger'] > bears.average('hunger') }.map { |bear| bear['name'] }.sort
```

## A first approach

I'm doing this in Clojure just to make my life difficult.

But it turns out that Clojure can do a pretty good job of translating my pseudo-code:

* calculate the average hunger with a map-reduce
* filter the list of bears by hunger
* map the name and sort

See source [src/challenge.clj](src/challenge.clj); there are no dependencies required:

```clojure
(ns challenge)

(defn hungry-bears [bears]
  (let [avg (/ (reduce + (map :hunger bears)) (count bears))]
    (->> bears (filter #(> (:hunger %) avg)) (map :name) sort)))


(defn run [opts]
  (println
    (hungry-bears
      [
        {:name "Baloo" :hunger 6}
        {:name "Yogi" :hunger 9}
        {:name "Paddington" :hunger 4}
        {:name "Winnie" :hunger 10}
        {:name "Chicago" :hunger 20}
      ]
    )))
```

And the result is as expected:

```sh
$ clj -X challenge/run
(Chicago Winnie)
```

## Credits and References

* [cassidoo's interview question of the week (2026-01-12)](https://buttondown.com/cassidoo/archive/the-future-is-sending-back-good-wishes-and/)
* [LCK#399 About Clojure](../about/)
