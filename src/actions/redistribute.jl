
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
    if (!result[1])
        challenger.balance += 2 * deposit
    end
end

"""
Redistribution model when the challenger is rewarded and all who voted
against him are punished
"""
function punishmentRedistribution(result, challenger, deposit)
    if (!result[1])
        challenger.balance += 2 * deposit
        foreach(agent -> agent.balance -= deposit / length(result[2]), result[2])
    end
end

"""
Redistribution model when all of voters who supported him are rewarded
"""
function rewardRedistribution(result, challenger, deposit)
    if (!result[1])
        challenger.balance += deposit
        foreach(agent -> agent.balance += deposit / length(result[3]), result[3])
    end
end

"""
Redistribution model when both the challenger is rewarded and voters who supported
him are rewarded and all who voted against him are punished
"""
function punishmentAndRewardRedistribution(result, challenger, deposit)
    if (!result[1])
        challenger.balance += 2 * deposit
        foreach(agent -> agent.balance -= deposit / length(result[2]), result[2])
        foreach(agent -> agent.balance += deposit / length(result[3]), result[3])
    end
end
