# 02 — stem, stairs, bars, error bars and a histogram: the discrete plots.
# Tags: [Julia] Base Julia · [JulixPlot] this package.
using JulixPlot

out = mkpath(joinpath(@__DIR__, "out"))             # [Julia]
n = 0:20                                            # [Julia]
h = 0.85 .^ n .* cos.(0.6 .* n)                     # [Julia] an impulse response

fig = Figure(; size = (900, 600))                   # [JulixPlot]
ax1 = Axis(fig[1, 1]; title = "impulse response h[n]", xlabel = "n")      # [JulixPlot]
stem!(ax1, n, h)                                    # [JulixPlot] Makie's stem recipe (offset, trunk, markers)
ax2 = Axis(fig[1, 2]; title = "step response", xlabel = "n")              # [JulixPlot]
stairs!(ax2, n, cumsum(h); step = :post, linewidth = 2)                   # [JulixPlot]; cumsum is [Julia]
ax3 = Axis(fig[2, 1]; title = "bars with error bars", xticks = (1:4, ["A", "B", "C", "D"]))
values = [4.2, 6.1, 3.3, 5.0]; errs = [0.4, 0.7, 0.3, 0.5]               # [Julia]
barplot!(ax3, 1:4, values; color = [:steelblue, :orange, :seagreen, :purple])   # [JulixPlot]
errorbars!(ax3, 1:4, values, errs; whiskerwidth = 12)                     # [JulixPlot]
ax4 = Axis(fig[2, 2]; title = "histogram (pdf)")                          # [JulixPlot]
samples = [sum(sin(13.7k * j) for j in 1:6) for k in 1:3000]             # [Julia] a deterministic sample
hist!(ax4, samples; bins = 40, normalization = :pdf)                      # [JulixPlot]
save(joinpath(out, "02_discrete.png"), fig)
save(joinpath(out, "02_discrete.pdf"), fig)
