include("./Agents.jl")
include("./Items.jl")


module Actions
    import Agents
    import Items

    function vote(registry, candidate, agents)
        pro = 0
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        for agent in agents
            pro += (Agents.evaluate(candidate, agent) > benchmark) ? 1 : 0
        end
        return pro > length(agents)/2;
    end

    function tokenHoldersVote(registry, candidate, agents)
        pro = 0
        quorum = 0
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        for agent in agents
            if agent.balance > 0
                pro += (Agents.evaluate(candidate, agent) > benchmark) ? 1 : 0
                quorum += 1
            end
        end
        return pro > quorum/2;
    end

    function tokenProRataVote(registry, candidate, agents)
        pro = 0
        quorum = 0
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        for agent in agents
            if agent.balance > 0
                pro += (Agents.evaluate(candidate, agent) > benchmark) ? agent.balance : 0
                quorum += agent.balance
            end
        end

        return pro > quorum/2;
    end

    function randomChallenger(agents)
        agents[rand(1:end)]
    end

    function randomWithBalance(agents)
        filteredAgents = filter(a -> a.balance > 10, agents)
        randomChallenger(filteredAgents)
    end

    function noReward(votingResult, challenger, deposit)

    end

    function onlyChallengerReward(successful, challenger, deposit)
        challenger.balance += successful ? 2 * deposit : 0
    end

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
