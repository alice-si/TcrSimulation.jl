module TcrCore

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
    #Agents:
    Agent,
    setupAgentsWithFixedAccuracy,
    setupRandomAgents,
    evaluateCandidateByAgent,
    evaluateCandidateByAgentPrecise,
    #Items:
    getCandidate,
    registryMean,
    #Actions:
    simpleVote,
    tokenHoldersVote,
    selectRandomAgent,
    selectRandomAgentWithMinBalance,
    noneRedistribution,
    onlyChallengerRewardRedistribution,
    challenge,
    application,
    #Simulations:
    simFixedAgentsNoChallenge,
    simFixedAgentsWithChallenge




##############################################################################
##
## Load files
##
##############################################################################

include("objects/items.jl")
include("objects/agents.jl")
include("actions/vote.jl")
include("actions/select-agent.jl")
include("actions/redistribute.jl")
include("actions/composite-actions.jl")
include("simulations/simulations.jl")

end # module TcrSimulations
