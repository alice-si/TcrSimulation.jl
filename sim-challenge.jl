# mutable struct Agent{TI<:Integer, TF<:AbstractFloat}
#     accuracy::TI
#     balance::TF
# end

using Plots
using Distributions

# constructor
Agent(a::Integer) = Agent(a, 100.0)

function evaluate(candidate, agent)
    evaluation = candidate + rand(Normal(0,(100-agent.accuracy)/10))
    # println("Candidate: $candidate Evaluation: $evaluation")
    return evaluation
end



function vote(registryMean, candidate, agents)
    count = 0
    for agent in agents
        count += (evaluate(candidate, agent) > registryMean) ? 1 : 0
    end
    println("Candidate: $candidate Vote: $count")

    return count > length(agents)/2;
end

function setupAgents(acc)
    agents = Agent[Agent(acc) for i in 1:100]
    return agents
end

function setupRandomAgents()
    agents = Agent[Agent(trunc(Int, rand(Normal(50,20)))) for i in 1:100]
end

function getCandidate()
    rand(Normal(50,15))
end

function application(registry, benchmark, agents)
    candidate = getCandidate()
    println("Candidate: $candidate")
    if vote(benchmark, candidate, agents)
        push!(registry, candidate);
    end
end

function challenge(registry, benchmark, agents)
    len = length(registry)
    println("Len: $len")
    if (length(registry) >= 10)
        challenger = agents[rand(1:end)]
        println("Challenger: $challenger")
        evaluations = evaluate.(registry, challenger)
        worstIndex = indmin(evaluations);
        min = evaluations[worstIndex]
        if !vote(benchmark, min, agents)
            println("Challenge successful: $min")
            deleteat!(registry, worstIndex)
        else
            println("Challenge failed: $min")
        end
    end
end

#PARAMETERS
num_of_steps = 300

registry = []
scores = [0.0]

# agents = setupAgents(70)
agents = setupRandomAgents()

for round in 1:num_of_steps
    println("Round: $round")
    application(registry, scores[end], agents)
    challenge(registry, scores[end], agents)
    push!(scores, mean(registry));
end

plot(scores, color="blue")
