module TcrSimulations

##############################################################################
##
## Dependencies
##
##############################################################################

using Distributions

##############################################################################
##
## Exported methods and types (in addition to everything reexported above)
##
##############################################################################

export
    #Items
    getCandidate,
    #Agents
    Agent,
    setupAgentsWithFixedAccuracy,
    setupRandomAgents,
    evaluateCandidateByAgent,
    evaluateCandidateByAgentPrecise,
    #Actions,
    simpleVote,
    tokenHoldersVote

##############################################################################
##
## Load files
##
##############################################################################

include("objects/items.jl")
include("objects/agents.jl")
include("actions/vote.jl")

end # module TcrSimulations
