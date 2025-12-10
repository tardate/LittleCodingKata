cassius := Object clone
cassius speak := method(
            "Cassius: You wrong me every way; you wrong me, Brutus." println
            yield 
            "Cassius: I am." println
             yield)

brutus := Object clone

brutus reply := method(
			yield
            "Brutus: I said an elder soldier, not a better." println
            yield 
            "Brutus: If you were better, you should know it." println)

cassius @@speak; brutus @@reply

Coroutine currentCoroutine pause