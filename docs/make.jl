using Documenter

try
    using TcrSimulation
catch
    if !("../src/" in LOAD_PATH)
       push!(LOAD_PATH,"../src/")
       @info "Added \"../src/\"to the path: $LOAD_PATH "
       using TcrSimulation
    end
end

makedocs(
    sitename = "TcrSimulation",
    format = format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    ),
    modules = [TcrSimulation],
    pages = ["index.md", "reference.md"],
    doctest = true
)



deploydocs(
    repo ="github.com/alice-si/TcrSimulation.jl.git",
    target="build"
)
