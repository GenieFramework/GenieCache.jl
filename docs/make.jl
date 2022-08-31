using Documenter

push!(LOAD_PATH,  "../../src")

using GenieCache

makedocs(
    sitename = "GenieCache - Caching support for Genie",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Home" => "index.md",
        "GenieCache API" => [
          "GenieCache" => "api/geniecache.md",
        ]
    ],
)

deploydocs(
  repo = "github.com/GenieFramework/GenieCache.jl.git",
)
