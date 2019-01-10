module TcrCore

##############################################################################
##
## Dependencies
##
##############################################################################

using Distributions, HypothesisTests, StatsBase

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
    binaryTokenVote,
    proRataTokenVote,
    selectRandomAgent,
    selectRandomAgentWithMinBalance,
    noneRedistribution,
    onlyChallengerRewardRedistribution,
    challenge,
    application,

    #Simulations:
    simSimple,
    simChallenge


    #Experiments
    # sim,
    # sim2

    #
    # simFixedAgentsNoChallenge,
    # simFixedAgentsWithChallenge,
    # simDiversifiedAgentsWithChallenge,
    # simWithBinTokens,
    # simWithProRataTokens,
    # simWithTokensMixed




##############################################################################
##
## Load files
##
##############################################################################

include("environment/items.jl")
include("environment/agents.jl")
include("actions/vote.jl")
include("actions/select-agent.jl")
include("actions/redistribute.jl")
include("actions/composite-actions.jl")
include("simulations/simulations.jl")
include("experiments/benchmarks.jl")
include("experiments/scenarios.jl")

end # module TcrSimulations
