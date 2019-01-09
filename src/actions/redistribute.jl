
"""
Void placeholder communicating that there is no redistribution happening
"""
function noneRedistribution(votingResult, challenger, deposit)

end

"""
Redistribution model when only the challenger receives the reward
in the form of the initial applicant deposit and the challenge fee
both being the same amount
"""
function onlyChallengerRewardRedistribution(result, challenger, deposit)
    if (result[1])
        # foreach(agent -> agent.balance += deposit / length(result[2]), result[2])
    else
        challenger.balance += 2 * deposit
        # foreach(agent -> agent.balance -= deposit / length(result[3]), result[3])
    end
end
