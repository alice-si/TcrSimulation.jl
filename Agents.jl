module Agents

    mutable struct Agent{TI<:Integer, TF<:AbstractFloat}
        accuracy::TI
        balance::TF
    end

    # constructor
    Agent(a::Integer) = Agent(a, 100.0)

    function setupAgentsWithFixedAccuracy(count, acc)
        Agent[Agent(acc) for i in 1:count]
    end

    function setupRandomAgents(count)
        agents = Agent[Agent(trunc(Int, rand(Normal(50,20)))) for i in 1:count]
    end

    function evaluate(candidate, agent)
        evaluation = candidate + randn() * (100-agent.accuracy)/3;
        # println("Candidate: $candidate Evaluation: $evaluation")
        return evaluation
    end

end
