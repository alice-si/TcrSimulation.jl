include("./Agents.jl")
include("./Items.jl")
include("./Actions.jl")
include("./Benchmarks.jl")

import Agents
import Items
import Actions
import Benchmarks

function runTokenSimulation(num_of_steps, num_of_agents, acc, div)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, acc, div)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
        Actions.fasterTokenChallenge(registry, agents)
    end
    len = length(registry)

    Benchmarks.score(registry)
    # Benchmarks.effectiveAccuracy(agents)
end




Run scenario (the impact of accuracy on list quality, 10 iterations)
for acc in 0:10:100
    score = mean([runTokenSimulation(1000, 100, acc, 20) for i in 1:20])
    println("$acc, $score")
    #println("$score")
end


#
# #RESULTS
# plot(scores, color="blue")
