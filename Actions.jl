include("./Agents.jl")
include("./Items.jl")


module Actions
    import Agents
    import Items

    function vote(registry, candidate, agents)
        count = 0
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        for agent in agents
            count += (Agents.evaluate(candidate, agent) > benchmark) ? 1 : 0
        end
        # println("Candidate: $candidate Benchmark: $benchmark Vote: $count")

        return count > length(agents)/2;
    end

    function challenge(registry, agents)
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        len = length(registry)
        println("Len: $len")
        if (length(registry) >= 10)
            challenger = agents[rand(1:end)]
            println("Challenger: $challenger")
            evaluations = Agents.evaluate.(registry, challenger)
            worstIndex = indmin(evaluations);
            min = evaluations[worstIndex]
            if !vote(registry, min, agents)
                println("Challenge successful: $min")
                deleteat!(registry, worstIndex)
            else
                println("Challenge failed: $min")
            end
        end
    end

    function application(registry, history, agents)
        candidate = Items.getCandidate()
        push!(history, candidate)
        # println("Candidate: $candidate")
        if vote(registry, candidate, agents)
            push!(registry, candidate);
        end
    end

end
