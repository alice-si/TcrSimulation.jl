module TcrExp

##############################################################################
##
## Dependencies
##
##############################################################################

using StatsBase, TcrCore

##############################################################################
##
## Exported methods and types (in addition to everything reexported above)
##
##############################################################################

export
    #Benchmarks:
    benchmarkRegistryMean,
    #Scenarios:
    compareRegistryQuality



##############################################################################
##
## Load files
##
##############################################################################


include("benchmarks.jl")
include("scenarios.jl")
include("start.jl")

end # module TcrSimulations
