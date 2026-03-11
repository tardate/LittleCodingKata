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
