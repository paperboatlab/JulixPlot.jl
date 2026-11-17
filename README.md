# SqueroPlot.jl

2D and 3D figure generation for Julia in the [Paperboat](https://github.com/paperboatlab/paperboat)
and Squero Studio MX ecosystem: axes, legends, colour bars and grid layouts written to PNG, SVG,
PDF, EPS and standalone HTML, with immutable snapshots for GUI figure history. The API follows
[Makie](https://docs.makie.org)'s conventions on a lightweight Cairo renderer with bundled fonts,
no GPU requirement and no Makie dependency.

**Docs:** [`docs/`](docs/) (`julia --project=docs docs/make.jl`)

## Use

Requires Julia 1.11 or newer:

```julia
using Pkg
Pkg.develop(path = "path/to/SqueroPlot.jl")

using SqueroPlot
x = range(0, 2π; length = 100)
fig = Figure()
ax = Axis(fig[1, 1]; title = "Waves", xlabel = "x", ylabel = "y")
lines!(ax, x, sin.(x); label = "sin")
scatter!(ax, x, cos.(x); label = "cos")
axislegend(ax)
save("figure.svg", fig)
```

## Check

```sh
julia --project=. -e 'using Pkg; Pkg.test()'
julia --project=docs docs/make.jl
```

## CI

[![ci](https://github.com/paperboatlab/SqueroPlot.jl/actions/workflows/ci.yml/badge.svg?branch=dev)](https://github.com/paperboatlab/SqueroPlot.jl/actions/workflows/ci.yml?query=branch%3Adev) runs the Julia test suite and builds the documentation.

## Licence

Mozilla Public License Version 2.0 (see [LICENSE](LICENSE)). Bundled fonts and adapted colour-scheme
utilities carry their own notices in [NOTICE.md](NOTICE.md).
