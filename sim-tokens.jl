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


# score = mean([runTokenSimulation(1000, 50, 60, 20) for i in 1:100])
# println(score)



#Run scenario (the impact of accuracy on list quality, 10 iterations)
for acc in 0:2:100
    score = mean([runTokenSimulation(1000, 50, acc, 20) for i in 1:30])
    println("$acc, $score")
    #println("$score")
end
