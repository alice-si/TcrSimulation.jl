mutable struct Agent{TI<:Integer, TF<:Float64}
    accuracy::TI
    balance::TF
end

# constructor
Agent(a::Integer) = Agent(min(100,a), 50.0)

function setupAgentsWithFixedAccuracy(count, acc)
    Agent[Agent(acc) for i in 1:count]
end

function setupRandomAgents(count, mean, std)
    agents = Agent[Agent(trunc(Int, rand(Normal(mean, std)))) for i in 1:count]
end

"""
TODO: consider parametrising the evaluate function
"""
function evaluateCandidateByAgent(candidate, agent)
    evaluation = candidate + rand(Normal((100-agent.accuracy)/3, 3))
    # acc = agent.accuracy
    # println("Candidate: $candidate Agent: $acc Evaluation: $evaluation")
end

function evaluateCandidateByAgentPrecise(candidate, agent)
    evaluation = candidate + (100-agent.accuracy)/3
    # acc = agent.accuracy
    # println("Candidate: $candidate Agent: $acc Evaluation: $evaluation")
end
