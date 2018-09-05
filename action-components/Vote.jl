
include("../Agents.jl")

module Vote

    import Agents

    function simple(registry, candidate, agents)
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
end
