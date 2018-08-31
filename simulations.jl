include("./Agents.jl")
include("./Items.jl")
include("./Actions.jl")
include("./Benchmarks.jl")

import Agents
import Items
import Actions
import Benchmarks

function fixedAgentsNoChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupAgentsWithFixedAccuracy(num_of_agents, accuracy)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
    end

    benchmark(registry, agents)
end


function fixedAgentsWithChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupAgentsWithFixedAccuracy(num_of_agents, accuracy)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
        Actions.challenge(registry, agents, Actions.randomChallenger, 0, Actions.vote, Actions.noReward)
    end

    benchmark(registry, agents)
end


function lowDiversityWithChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, accuracy, 10)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
        Actions.challenge(registry, agents, Actions.randomChallenger, 0, Actions.vote, Actions.noReward)
    end

    benchmark(registry, agents)
end

function highDiversityWithChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, accuracy, 20)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
        Actions.challenge(registry, agents, Actions.randomChallenger, 0, Actions.vote, Actions.noReward)
    end

    benchmark(registry, agents)
end


function binaryTokenChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, accuracy, 20)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
        Actions.challenge(registry, agents, Actions.randomWithBalance, 10, Actions.tokenHoldersVote, Actions.onlyChallengerReward)
    end

    benchmark(registry, agents)
end


function proRataTokenChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, accuracy, 20)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
        Actions.challenge(registry, agents, Actions.randomWithBalance, 10, Actions.tokenProRataVote, Actions.onlyChallengerReward)
    end

    benchmark(registry, agents)
end



for acc in 0:10:100
    score = mean([highDiversityWithChallenge(1000, 100, acc, Benchmarks.registryMean) for i in 1:20])
    println("$acc, $score")
end
