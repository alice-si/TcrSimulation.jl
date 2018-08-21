include("./Agents.jl")
include("./Items.jl")
include("./Actions.jl")
include("./Benchmarks.jl")

import Agents
import Items
import Actions
import Benchmarks

function runSimulation(num_of_steps, num_of_agents, acc)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, acc, 20)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
        Actions.tokenChallenge(registry, agents)
    end
    len = length(registry)
    #println("Length: $len")

    accs = []
    for agent in agents
        push!(accs, agent.accuracy)
    end
    # meanAccuracy = mean(accs)
    # println("Mean accuracy: $meanAccuracy")
    #
    # eAcc = []
    # count = 0
    # for agent in agents
    #     if agent.balance > 0
    #         push!(eAcc, agent.accuracy)
    #         count = count + 1
    #     end
    # end
    # meanEffective = mean(eAcc)
    # println("Count: $count Effective accuracy: $meanEffective")

    Benchmarks.score(registry)
    # for agent in agents
    #     a = agent.accuracy
    #     b = agent.balance
    #     println("Accuracy: $a Balance: $b")
    # end
end

m = mean([runSimulation(1500, 100, 70) for i in 1:20])
println("Result: $m")



#Run scenario (the impact of accuracy on list quality, 10 iterations)
for std in 50:5:80
    score = mean([runSimulation(1000, 50, std) for i in 1:10])
    println("$score")
    #println("$score")
end




#
# #RESULTS
# plot(scores, color="blue")
