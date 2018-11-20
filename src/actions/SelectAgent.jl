
module SelectAgent
    function random(agents)
        agents[rand(1:end)]
    end

    function randomWithBalance(agents)
        filteredAgents = filter(a -> a.balance > 10, agents)
        randomChallenger(filteredAgents)
    end

end
