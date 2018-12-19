

function noneRedistribution(votingResult, challenger, deposit)

end

function onlyChallengerRewardRedistribution(result, challenger, deposit)
    if (result[1])
        # foreach(agent -> agent.balance += deposit / length(result[2]), result[2])
    else
        challenger.balance += 2 * deposit
        # foreach(agent -> agent.balance -= deposit / length(result[3]), result[3])
    end
end
