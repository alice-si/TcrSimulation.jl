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
    fullRedistribution,
    challenge,
    application,

    #Simulations:
    simSimple,
    simChallenge,
    simToken


    #Research
    # tokensAndDiversifications,
    # tokensAndDiversificationsEffects





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
include("experiments/sample-scenarios.jl")
include("experiments/research.jl")

end # module TcrSimulations
