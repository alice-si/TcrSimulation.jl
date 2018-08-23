module Agents

    using Distributions

    mutable struct Agent{TI<:Integer, TF<:AbstractFloat}
        accuracy::TI
        balance::TF
    end

    # constructor
    Agent(a::Integer) = Agent(a, 100.0)

    function setupAgentsWithFixedAccuracy(count, acc)
        Agent[Agent(acc) for i in 1:count]
    end

    function setupRandomAgents(count, mean, std)
        agents = Agent[Agent(trunc(Int, rand(Normal(mean, std)))) for i in 1:count]
    end

    function evaluate(candidate, agent)
        evaluation = candidate + rand(Normal((100-agent.accuracy)/3, 3))
        # acc = agent.accuracy
        # println("Candidate: $candidate Agent: $acc Evaluation: $evaluation")
    end

    function evaluateFixed(candidate, agent)
        evaluation = candidate + (100-agent.accuracy)/3
        # acc = agent.accuracy
        # println("Candidate: $candidate Agent: $acc Evaluation: $evaluation")
    end

end
