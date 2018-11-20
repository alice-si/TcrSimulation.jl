
function challenge(registry, agents, deposit, voteFunc, redistributionFunc)
    if (length(registry) >= 10)
        challenger = agents[rand(1:end)]
        evaluations = Agents.evaluate.(registry, challenger)
        worstIndex = indmin(evaluations);
        min = evaluations[worstIndex]

        # if (min < mean(registry))
            challenger.balance -= deposit

            # objective = registry[worstIndex]
            # println("Challenge:  $min Objective: $objective")
            votingResult = voteFunc(registry, min, agents, deposit)
            if (!votingResult[1])
                deleteat!(registry, worstIndex)
            end
            redistributionFunc(votingResult, challenger, deposit)
        # end
    end
end

function application(registry, history, agents, voteFunc, deposit)
    candidate = Items.getCandidate()
    push!(history, candidate)
    # println("Candidate: $candidate")
    if voteFunc(registry, candidate, agents, deposit)[1]
        push!(registry, candidate);
    end
end
