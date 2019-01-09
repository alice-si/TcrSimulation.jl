
"""
A function to uniformly select a random agent from a collection
"""
function selectRandomAgent(agents)
    agents[rand(1:end)]
end

"""
A function that unifromly select an agent from a subgroup of agents that have
a minimum amount of tokens. It could be useful to select an agent that is capable
of making a deposit
"""
function selectRandomAgentWithMinBalance(agents, min)
    filteredAgents = filter(a -> a.balance > min, agents)
    selectRandomAgent(filteredAgents)
end
