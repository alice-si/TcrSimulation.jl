include("./Agents.jl")
include("./Items.jl")


module Actions
    import Agents
    import Items

    function vote(registry, candidate, agents)
        count = length(registry) == 0 ? 0 : mean(registry)
        benchmark = mean(registry)
        for agent in agents
            count += (Agents.evaluate(candidate, agent) > benchmark) ? 1 : 0
        end
        # println("Candidate: $candidate Vote: $count")

        return count > length(agents)/2;
    end

    function challenge(registry, agents)
        benchmark = length(registry) == 0 ? 0 : mean(registry)
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

    function application(registry, agents)
        candidate = Items.getCandidate()
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        println("Candidate: $candidate")
        if vote(benchmark, candidate, agents)
            push!(registry, candidate);
        end
    end

end
