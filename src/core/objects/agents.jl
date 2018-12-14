mutable struct Agent{TI<:Integer, TF<:Float64}
    accuracy::TI
    balance::TF
end

# constructor
Agent(a::Integer) = Agent(min(100,a), 50.0)

function setupAgentsWithFixedAccuracy(count, acc)
    Agent[Agent(acc) for i in 1:count]
end

function setupRandomAgents(rng, count, mean, std)
    agents = Agent[Agent(trunc(Int, rand(rng, Normal(mean, std)))) for i in 1:count]
end

function evaluateCandidateByAgent(rng, candidate, agent)
    if (agent.accuracy == 100)
        candidate
    else
        evaluation = rand(rng, Normal(candidate, (100-agent.accuracy)/2))
        candidate + abs(evaluation - candidate)
    end
end

# """
# TODO: consider parametrising the evaluate function
# """
function evaluateCandidateByAgentRandomized(rng, candidate, agent)
    evaluation = candidate + rand(rng, Normal((100-agent.accuracy)/3, 3))
    # acc = agent.accuracy
    # println("Candidate: $candidate Agent: $acc Evaluation: $evaluation")
end

function evaluateCandidateByAgentFixed(rng, candidate, agent)
    evaluation = candidate + (100-agent.accuracy)/3
    # acc = agent.accuracy
    # println("Candidate: $candidate Agent: $acc Evaluation: $evaluation")
end
