include("./Agents.jl")
include("./Items.jl")
include("./Actions.jl")
include("./Benchmarks.jl")
include("./action-components/Vote.jl")
include("./action-components/Redistribute.jl")

import Agents
import Items
import Actions
import Benchmarks
import Vote
import Redistribute

function fixedAgentsNoChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupAgentsWithFixedAccuracy(num_of_agents, accuracy)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents, Vote.simple)
    end

    [b(registry, agents) for b in benchmarks]
end


function fixedAgentsWithChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupAgentsWithFixedAccuracy(num_of_agents, accuracy)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents, Vote.simple)
        Actions.challenge(registry, agents, 0, Vote.simple, Redistribute.none)
    end

    [b(registry, agents) for b in benchmarks]
end


function diversityWithChallenge(num_of_steps, num_of_agents, accuracy, diversity, benchmarks)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, accuracy, diversity)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents, Vote.simple)
        Actions.challenge(registry, agents, 0, Vote.simple, Redistribute.none)
    end

    [b(registry, agents) for b in benchmarks]
end



function binaryTokenChallenge(num_of_steps, num_of_agents, accuracy, diversity, benchmarks)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, accuracy, diversity)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents, Vote.tokenHoldersVote)
        Actions.challenge(registry, filter(a -> a.balance > 0, agents), 10, Vote.tokenHoldersVote, Redistribute.onlyChallengerReward)
    end

    [b(registry, agents) for b in benchmarks]
end


function proRataTokenChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, accuracy, 20)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents, Vote.tokenProRataVote)
        Actions.challenge(registry, agents, 10, Vote.tokenProRataVote, Redistribute.onlyChallengerReward)
    end

    benchmark(registry, agents)
end

fixedAgentsWithChallenge(100, 50, 50,
 [Benchmarks.accuracyBoost, Benchmarks.accuracyBalanceCorrelation,
  Benchmarks.registryMean])
