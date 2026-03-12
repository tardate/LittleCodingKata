using Distributed

function pflip_coins(times)
    @distributed (+) for i = 1:times
        Int(rand(Bool))
    end
end

function flip_coins_histogram(trials, times)
  bars = zeros(Int, times + 1)
  for i = 1:trials
    bars[pflip_coins(times) + 1] += 1
  end
  hist = pmap((len -> repeat("*", Int(len))), bars)
  for line in hist
    println("|$(line)")
  end
end

function main()
    if length(ARGS) != 2
        println("Usage: julia coinflips.jl <trials> <times>")
        exit(1)
    end

    trials = parse(Int, ARGS[1])
    times = parse(Int, ARGS[2])

    flip_coins_histogram(trials, times)
end

main()
