include("./Agents.jl")
include("./Items.jl")
include("./Actions.jl")
include("./Benchmarks.jl")

import Agents
import Items
import Actions
import Benchmarks

using Plots
using Distributions


function runSimulation(num_of_steps, num_of_agents, accuracy)
    registry = []
    history = []
    agents = Agents.setupAgentsWithFixedAccuracy(num_of_agents, accuracy)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
    end

    plot(scores, color="blue")
    ev = Benchmarks.score(registry)
    return ev
end

for acc in 0:100:10
    evs = []
    for i in 1:100
        push!(evs,runSimulation(500, 100, acc))
    end
    score = mean(evs)
    println("Accuracy: $acc Score: $score")
end




#
# #RESULTS
# plot(scores, color="blue")
