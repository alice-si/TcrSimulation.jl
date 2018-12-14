

function simFixedAgentsNoChallenge(rng, num_of_steps, num_of_agents, accuracy, benchmarks)
    registry = []
    history = []
    agents = setupAgentsWithFixedAccuracy(num_of_agents, accuracy)

    for round in 1:num_of_steps
        application(rng, registry, history, agents, simpleVote)
    end

    [b(registry, agents) for b in benchmarks]
end


function simFixedAgentsWithChallenge(rng, num_of_steps, num_of_agents, accuracy, benchmarks)
    registry = []
    history = []
    agents = setupAgentsWithFixedAccuracy(num_of_agents, accuracy)

    for round in 1:num_of_steps
        application(rng, registry, history, agents, simpleVote)
        challenge(rng, registry, agents, 0, simpleVote, noneRedistribution)
    end

    [b(registry, agents) for b in benchmarks]
end


function simDiversifiedAgentsWithChallenge(rng, num_of_steps, num_of_agents, accuracy, std, benchmarks)
    registry = []
    history = []
    agents = setupRandomAgents(rng, num_of_agents, accuracy, std)

    for round in 1:num_of_steps
        application(rng, registry, history, agents, simpleVote)
        challenge(rng, registry, agents, 0, simpleVote, noneRedistribution)
    end

    [b(registry, agents) for b in benchmarks]
end


function simWithBinTokens(rng, num_of_steps, num_of_agents, accuracy, std, benchmarks)
    registry = []
    history = []
    agents = setupRandomAgents(rng, num_of_agents, accuracy, std)

    for round in 1:num_of_steps
        application(rng, registry, history, agents, binaryTokenVote)
        challenge(rng, registry, agents, 10, binaryTokenVote, onlyChallengerRewardRedistribution)
    end

    [b(registry, agents) for b in benchmarks]
end

function simWithProRataTokens(rng, num_of_steps, num_of_agents, accuracy, std, benchmarks)
    registry = []
    history = []
    agents = setupRandomAgents(rng, num_of_agents, accuracy, std)

    for round in 1:num_of_steps
        application(rng, registry, history, agents, proRataTokenVote)
        challenge(rng, registry, agents, 10, proRataTokenVote, onlyChallengerRewardRedistribution)
    end

    [b(registry, agents) for b in benchmarks]
end



#
#
#
# function binaryTokenChallenge(num_of_steps, num_of_agents, accuracy, diversity, benchmarks)
#     registry = []
#     history = []
#     agents = Agents.setupRandomAgents(num_of_agents, accuracy, diversity)
#
#     for round in 1:num_of_steps
#         Actions.application(registry, history, agents, Vote.tokenHoldersVote, 10)
#         Actions.challenge(registry, filter(a -> a.balance > 0, agents), 10, Vote.tokenHoldersVote, Redistribute.onlyChallengerReward)
#     end
#
#     [b(registry, agents) for b in benchmarks]
# end
#
#
# function proRataTokenChallenge(num_of_steps, num_of_agents, accuracy, diversity, benchmarks)
#         registry = []
#         history = []
#         agents = Agents.setupRandomAgents(num_of_agents, accuracy, diversity)
#
#         for round in 1:num_of_steps
#             Actions.application(registry, history, agents, Vote.tokenProRataVote)
#             Actions.challenge(registry, filter(a -> a.balance > 0, agents), 10, Vote.tokenProRataVote, Redistribute.onlyChallengerReward)
#
#             println("------------------")
#             for ag in agents
#                 acc = ag.accuracy
#                 bal = ag.balance
#                 println("$acc $bal")
#             end
#
#         end
#
#
#
#         [b(registry, agents) for b in benchmarks]
# end


# d  = binaryTokenChallenge(1000, 50, 60, 10, [Benchmarks.registryMean])
# println(d)

#GPLOT2 - do wykresów
