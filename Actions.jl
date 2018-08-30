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

    function tokenVote(registry, candidate, agents)
        pro = 0
        quorum = 0
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        for agent in agents
            if agent.balance > 0
                pro += (Agents.evaluate(candidate, agent) > benchmark) ? 1 : 0
                quorum += 1
            end
        end
        # println("Candidate: $candidate Benchmark: $benchmark Vote: $count")

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

    function challenge(registry, agents)
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        len = length(registry)
        #println("Len: $len")
        if (length(registry) >= 10)
            challenger = agents[rand(1:end)]
            #println("Challenger: $challenger")
            evaluations = Agents.evaluate.(registry, challenger)
            worstIndex = indmin(evaluations);
            min = evaluations[worstIndex]
            if !vote(registry, min, agents)
                #println("Challenge successful: $min")
                deleteat!(registry, worstIndex)
            else
                #println("Challenge failed: $min")
            end
        end
    end

    function tokenChallenge(registry, agents)
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        if (length(registry) >= 10)
            challenger = agents[rand(1:end)]
            if (challenger.balance >= 10.0)
                challenger.balance -= 10.0
                #println("Challenger: $challenger")
                evaluations = Agents.evaluate.(registry, challenger)
                worstIndex = indmin(evaluations);
                min = evaluations[worstIndex]
                if !tokenVote(registry, min, agents)
                    #println("Challenge successful: $min")
                    deleteat!(registry, worstIndex)
                    challenger.balance += 20.0
                else
                    #println("Challenge failed: $min")
                end
            else
                #println("No funds!!!")
            end
        end
    end

    function proRataTokenChallenge(registry, agents)
        if (length(agents) > 0)
            benchmark = length(registry) == 0 ? 0 : mean(registry)
            if (length(registry) >= 10)
                challenger = agents[rand(1:end)]
                if (challenger.balance >= 10.0)
                    challenger.balance -= 10.0
                    #println("Challenger: $challenger")
                    evaluations = Agents.evaluate.(registry, challenger)
                    worstIndex = indmin(evaluations);
                    min = evaluations[worstIndex]
                    if !tokenProRataVote(registry, min, agents)
                        #println("Challenge successful: $min")
                        deleteat!(registry, worstIndex)
                        challenger.balance += 20.0
                    else
                        #println("Challenge failed: $min")
                    end
                else
                    #println("No funds!!!")
                end
            end
        end
    end

    function fasterTokenChallenge(registry, agents)
        Actions.tokenChallenge(registry, filter(a -> a.balance > 10, agents))
    end

    function fasterProRataTokenChallenge(registry, agents)
        Actions.proRataTokenChallenge(registry, filter(a -> a.balance > 10, agents))
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
