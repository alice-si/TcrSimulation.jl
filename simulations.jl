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
        Actions.challenge(registry, agents, 0, Actions.vote, Actions.noReward)
    end

    benchmark(registry, agents)
end


function lowDiversityWithChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, accuracy, 10)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
        Actions.challenge(registry, agents, 0, Actions.vote, Actions.noReward)
    end

    benchmark(registry, agents)
end

function highDiversityWithChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, accuracy, 20)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
        Actions.challenge(registry, agents, 0, Actions.vote, Actions.noReward)
    end

    benchmark(registry, agents)
end


function binaryTokenChallenge(num_of_steps, num_of_agents, accuracy, benchmark)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, accuracy, 20)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
        Actions.challenge(registry, filter(a -> a.balance > 0, agents), 10, Actions.tokenHoldersVote, Actions.onlyChallengerReward)
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

score = mean([binaryTokenChallenge(1000, 50, 70, Benchmarks.registryMean) for i in 1:20])
println(score)

# for acc in 60:2:80
#     score = mean([highDiversityWithChallenge(1000, 50, acc, Benchmarks.registryMean) for i in 1:20])
#     println("$acc, $score")
# end
