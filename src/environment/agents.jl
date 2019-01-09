"""
A struct that represents an agent storing it's accuracy and balance.
The accurancy is set up once during the agent creation and remain the same during the simulation.
The balance is updated accoring to agent's perfromance in the curation process.
"""
mutable struct Agent{TI<:Integer, TF<:Float64}
    accuracy::TI
    balance::TF
end


# constructor
Agent(a::Integer) = Agent(min(100,a), 50.0)


"""
Creates a group of X (count) agents all of them having the same accuracy (acc)
"""
function setupAgentsWithFixedAccuracy(count, acc)
    Agent[Agent(acc) for i in 1:count]
end


"""
Creates a group of X (count) agents all with accuracy distributed according to the
normal distribution with passed parameters (mean and std)
"""
function setupRandomAgents(count, mean, std)
    agents = Agent[Agent(trunc(Int, rand(TruncatedNormal(mean, std, 0, 100)))) for i in 1:count]
end

function setupMixedAgents(lowCount, lowAcc, highCount, highAcc)
    agents = vcat(setupAgentsWithFixedAccuracy(lowCount, lowAcc), setupAgentsWithFixedAccuracy(highCount, highAcc))
end


"""
This function represents the perception of an item by the agent.
Agents with lower accuracy tend to overrate an item.
This variation of the function rates the item with a fixed positive bias.
"""
function evaluateCandidateByAgentFixed(candidate, agent)
    evaluation = candidate + (100-agent.accuracy)/3
end


"""
This function represents the perception of an item by the agent.
Agents with lower accuracy tend to overrate an item.
This variation of the function rates the item with a randomized bias based on the normal distribution.
"""
function evaluateCandidateByAgent(candidate, agent)
    if (agent.accuracy == 100)
        candidate
    else
        evaluation = rand(Normal(candidate, (100-agent.accuracy)/3))
        candidate + abs(evaluation - candidate)
    end
end
