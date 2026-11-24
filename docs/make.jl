using Documenter
using JulixPlot

makedocs(;
    sitename = "JulixPlot.jl",
    modules = [JulixPlot],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", "false") == "true", size_threshold = 400_000,
        edit_link = nothing, repolink = "https://github.com/paperboatlab/JulixPlot.jl"),
    pages = [
        "Getting started" => "index.md",
        "Plot gallery" => "gallery.md",
        "Export" => "export.md",
        "GUI snapshots" => "snapshots.md",
        "API" => "api.md",
    ],
    checkdocs = :exports,
    remotes = nothing,   # a local repository; no source links
)
