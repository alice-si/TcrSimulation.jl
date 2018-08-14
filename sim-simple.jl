include("./Agents.jl")
include("./Items.jl")
include("./Actions.jl")
import Agents
import Items
import Actions

using Plots
using Distributions


#PARAMETERS
num_of_steps = 1000
num_of_agents = 100

#SETUP
registry = []
scores = [0.0]
agents = Agents.setupAgentsWithFixedAccuracy(num_of_agents, 40)


#MECHANICS
for round in 1:num_of_steps
    Actions.application(registry, agents)
    push!(scores, mean(registry));

end

#RESULTS
plot(scores, color="blue")
