
include("./Items.jl")
include("./Agents.jl")


module Actions

    import Items
    import Agents

    function challenge(registry, agents, deposit, voteFunc, redistributionFunc)
        if (length(registry) >= 10)
            challenger = agents[rand(1:end)]
            challenger.balance -= deposit
            evaluations = Agents.evaluate.(registry, challenger)
            worstIndex = indmin(evaluations);
            min = evaluations[worstIndex]
            votingResult = voteFunc(registry, min, agents)
            if (!votingResult)
                deleteat!(registry, worstIndex)
            end
            redistributionFunc(!votingResult, challenger, deposit)
        end
    end

    function application(registry, history, agents, voteFunc)
        candidate = Items.getCandidate()
        push!(history, candidate)
        # println("Candidate: $candidate")
        if voteFunc(registry, candidate, agents)
            push!(registry, candidate);
        end
    end

end
