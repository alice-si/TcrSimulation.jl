module TcrSimulation

##############################################################################
##
## Dependencies
##
##############################################################################

using Distributions, HypothesisTests, StatsBase, Random

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
    rewardRedistribution,
    punishmentRedistribution,
    punishmentAndRewardRedistribution,    
    fullRedistribution,
    challenge,
    application,

    #Simulations:
    simSimple,
    simChallenge,
    simToken,


    #Benchmarks
    benchmarkRegistryMean
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

end # module TcrSimulations
