
include("../Agents.jl")

module Vote

    import Agents

    function simple(registry, candidate, agents, deposit)
        pro = 0
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        for agent in agents
            pro += (Agents.evaluate(candidate, agent) > benchmark) ? 1 : 0
        end
        return [pro > length(agents)/2];
    end

    function oldTokenHoldersVote(registry, candidate, agents, deposit)
        pro = 0
        quorum = 0
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        for agent in agents
            if agent.balance > 0
                pro += (Agents.evaluate(candidate, agent) >  benchmark) ? 1 : 0
                quorum += 1
            end
        end
        return pro > quorum/2;
    end

    function tokenHoldersVote(registry, candidate, agents, deposit)
        rejectAgents = []
        proAgents = []
        quorum = 0
        benchmark = length(registry) == 0 ? 0 : mean(registry)
        for agent in agents
            if agent.balance > 0
                if (Agents.evaluate(candidate, agent) <= benchmark)
                    push!(rejectAgents, agent)
                else
                    push!(proAgents, agent)
                end
                quorum += 1
            end
        end
        [length(proAgents) > quorum/2, proAgents, rejectAgents]
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
end
