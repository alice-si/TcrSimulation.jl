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
    agents = Agent[Agent(trunc(Int, rand(TruncatedNormal(mean, std, 0, 100)))) for i in 1:count]
end

function setupMixedAgents(lowCount, lowAcc, highCount, highAcc)
    agents = vcat(setupAgentsWithFixedAccuracy(lowCount, lowAcc), setupAgentsWithFixedAccuracy(highCount, highAcc))
end

function evaluateCandidateByAgent(candidate, agent)
    if (agent.accuracy == 100)
        candidate
    else
        evaluation = rand(Normal(candidate, (100-agent.accuracy)/3))
        candidate + abs(evaluation - candidate)
    end
end

# """
# TODO: consider parametrising the evaluate function
# """
function evaluateCandidateByAgent2(candidate, agent)
    # error = (100-agent.accuracy)/3
    error = rand(Normal((100-agent.accuracy)/3, 3))
    # evaluation = candidate + rand(rng, Normal((100-agent.accuracy)/3, 3))
    candidate + abs(error)
    # candidate + error
    # acc = agent.accuracy
    # println("Candidate: $candidate Agent: $acc Evaluation: $evaluation")
end

function evaluateCandidateByAgentFixed(candidate, agent)
    evaluation = candidate + (100-agent.accuracy)/3
    # acc = agent.accuracy
    # println("Candidate: $candidate Agent: $acc Evaluation: $evaluation")
end
