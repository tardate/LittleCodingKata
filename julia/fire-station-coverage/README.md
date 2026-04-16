# #436 fireStationCoverage

Using Julia to calculate how well a city grid is covered by fire stations - a multi-source, breadth-first search problem; cassidoo's interview question of the week (2026-03-16).

## Notes

The [interview question of the week (2026-03-16)](https://buttondown.com/cassidoo/archive/u1faaa-your-work-feels-different-when-its-made/):

> You're given a 2D grid representing a city where each cell is either empty (0), a fire station (1), or a building (2). Fire stations can serve buildings based on horizontal + vertical moves only. Return a 2D grid where each cell shows the minimum distance to the nearest fire station.
>
> Examples:
>
> ```ts
> > fireStationCoverage([
>   [2, 0, 1],
>   [0, 2, 0],
>   [1, 0, 2]
> ])
> > [[2, 1, 0],
>    [1, 2, 1],
>    [0, 1, 2]]
>
> > fireStationCoverage([
>   [1, 0, 0, 1],
>   [0, 0, 0, 0],
>   [0, 0, 0, 0],
>   [1, 0, 0, 1]
> ])
> > [[0, 1, 2, 0],
>    [1, 2, 2, 1],
>    [1, 2, 2, 1],
>    [0, 1, 2, 0]]
> ```

NB: it seems the solution to the second example should in fact be:

```json
[[0, 1, 1, 0],
 [1, 2, 2, 1],
 [1, 2, 2, 1],
 [0, 1, 1, 0]]
```

## Thinking about the Problem

The first thing we can note is that buildings are irrelevant for the answer.

If we consider each fire station a "source", we have a [multi-source shortest path problem](https://en.wikipedia.org/wiki/Shortest_path_problem).

This is similar to [LeetCode 542](https://leetcode.com/problems/01-matrix/description/?show=1) - [solution](https://github.com/doocs/leetcode/tree/main/solution/0500-0599/0542.01%20Matrix).

## A first approach

As a general approach we can:

* initialize a queue with ALL fire station positions at distance 0
* multi-source [breadth-first search (BFS)](https://en.wikipedia.org/wiki/Breadth-first_search)
* Track distances in the result grid, updating when we find a shorter path

This ensures each cell is visited exactly once, and the first time we reach a cell is via the shortest path from the nearest fire station.

I'm doing this with Julia. See [LCK#430 About Julia](../about/) for more info on the language.

I'll be reading the input data as JSON, so I need to make sure that the Julia [JSON package](https://github.com/JuliaIO/JSON.jl) is installed.
I've coded the dependencies in [dependencies.jl](./dependencies.jl):

```sh
$ cat dependencies.jl
using Pkg
Pkg.Registry.add("General")
Pkg.add("JSON")
$ julia dependencies.jl
       Added `General` registry to ~/.julia/registries
    Updating registry at `~/.julia/registries/General.toml`
   Resolving package versions...
     Project No packages added to or removed from `~/.julia/environments/v1.12/Project.toml`
    Manifest No packages added to or removed from `~/.julia/environments/v1.12/Manifest.toml`
```

The core behaviour is implemented in the `fireStationCoverage` function:

```julia
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
```

### Testing with the Examples

The script takes the input matrix as a json file:

```sh
$ julia challenge.jl
Usage: julia challenge.jl <json_file>
```

Here's the solution with the first example dataset [data-example-1.json](./data-example-1.json):

```sh
$ cat data-example-1.json
[
  [2, 0, 1],
  [0, 2, 0],
  [1, 0, 2]
]
$ julia challenge.jl data-example-1.json
[[2,1,0],[1,2,1],[0,1,2]]
```

Looking good!

Here's the solution with the second example dataset [data-example-2.json](./data-example-2.json):

```sh
$ cat data-example-2.json
[
  [1, 0, 0, 1],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [1, 0, 0, 1]
]
$ julia challenge.jl data-example-2.json
[[0,1,1,0],[1,2,2,1],[1,2,2,1],[0,1,1,0]]
```

Also good. As noted above, I believe this is the correct answer, not the one given in the question.

### Final Code

See [challenge.jl](./challenge.jl) for the final code.

```julia
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
```

## Credits and References

* [cassidoo's interview question of the week (2026-03-16)](https://buttondown.com/cassidoo/archive/u1faaa-your-work-feels-different-when-its-made/)
* [LCK#430 About Julia](../about/)
* [LeetCode 542](https://leetcode.com/problems/01-matrix/description/?show=1)
* [LeetCode 542 solution](https://github.com/doocs/leetcode/tree/main/solution/0500-0599/0542.01%20Matrix).
* [JSON.jl](https://github.com/JuliaIO/JSON.jl)
