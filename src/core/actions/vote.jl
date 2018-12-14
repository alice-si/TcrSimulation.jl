

"""
The basic voting function when every agent's got an equal voting power
and the candidate is being compared to the registry mean
"""
function simpleVote(rng, benchmark, candidate, agents)
    rejectAgents = []
    proAgents = []
    quorum = length(agents)
    for agent in agents
        push!(evaluateCandidateByAgent(rng, candidate, agent) >= benchmark ? proAgents : rejectAgents, agent)
    end
    [length(proAgents) > quorum/2, proAgents, rejectAgents]
end


"""
The voting function when every agent's got an equal voting power
but only agents who hold some tokens are eligible to participate
"""
function binaryTokenVote(rng, benchmark, candidate, agents)
    rejectAgents = []
    proAgents = []
    quorum = 0
    for agent in agents
        if agent.balance > 0
            if (evaluateCandidateByAgent(rng, candidate, agent) <= benchmark)
                push!(rejectAgents, agent)
            else
                push!(proAgents, agent)
            end
            quorum += 1
        end
    end
    [length(proAgents) > quorum/2, proAgents, rejectAgents]
end


"""
The voting function when every agent's got a voting power
proportional to the amount of tokens under possesion
"""
function proRataTokenVote(rng, benchmark, candidate, agents)
    rejectAgents = []
    proAgents = []
    proTokens = 0
    quorum = 0
    for agent in agents
        if agent.balance > 0
            if (evaluateCandidateByAgent(rng, candidate, agent) <= benchmark)
                push!(rejectAgents, agent)
            else
                proTokens += agent.balance
                push!(proAgents, agent)
            end
            quorum += agent.balance
        end
    end
    [proTokens > quorum/2, proAgents, rejectAgents]
end
