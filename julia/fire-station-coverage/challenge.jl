using JSON

function fireStationCoverage(grid::Matrix)
  rows, cols = size(grid)
  distances = fill(typemax(Int), rows, cols)
  queue = []

  # Find all fire stations and initialize queue
  for i in 1:rows
    for j in 1:cols
      if grid[i, j] == 1
        distances[i, j] = 0
        push!(queue, (i, j))
      end
    end
  end

  # BFS to find distances to nearest fire station
  while !isempty(queue)
    i, j = popfirst!(queue)
    for (di, dj) in [(0, 1), (0, -1), (1, 0), (-1, 0)]
      ni, nj = i + di, j + dj
      if 1 ≤ ni ≤ rows && 1 ≤ nj ≤ cols && distances[ni, nj] > distances[i, j] + 1
        distances[ni, nj] = distances[i, j] + 1
        push!(queue, (ni, nj))
      end
    end
  end

  return distances
end

function main()
  if isempty(ARGS)
    println("Usage: julia challenge.jl <json_file>")
    exit(1)
  end

  filename = ARGS[1]
  try
    data = JSON.parsefile(filename)
    result = fireStationCoverage(reduce(hcat, data))
    println(JSON.json(result))
  catch e
    println("Error: Could not read file '$filename'")
    exit(1)
  end
end

main()
