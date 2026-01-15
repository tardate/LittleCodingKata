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
