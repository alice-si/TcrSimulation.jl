

function selectRandomAgent(agents)
    agents[rand(1:end)]
end

function selectRandomAgentWithMinBalance(agents, min)
    filteredAgents = filter(a -> a.balance > min, agents)
    selectRandomAgent(filteredAgents)
end
