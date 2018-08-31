include("./Agents.jl")
include("./Items.jl")
include("./Actions.jl")
include("./Benchmarks.jl")

import Agents
import Items
import Actions
import Benchmarks

function runDivSimulation(num_of_steps, num_of_agents, accuracy, div)
    registry = []
    history = []
    agents = Agents.setupRandomAgents(num_of_agents, accuracy, div)

    for round in 1:num_of_steps
        Actions.application(registry, history, agents)
        Actions.oldChallenge(registry, agents)
    end

    Benchmarks.registryMean(registry, agents)
end



#Run scenario (the impact of accuracy on list quality, 10 iterations)
for acc in 0:10:100
    score = mean([runDivSimulation(1000, 100, acc, 20) for i in 1:20])
    println("Accuracy: $acc Score: $score")

end




#
# #RESULTS
# plot(scores, color="blue")
