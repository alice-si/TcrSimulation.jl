function differentMechanisms()
    srand(1234)
    for acc in 0:5:100
        applicationOnly = mean([simSimple(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:20])[1]
        challenge = mean([simChallenge(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:20])[1]
        token = mean([simToken(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:20])[1]
        println("$acc, $applicationOnly, $challenge, $token")
    end
end


function tokensAndDiversifications()
    srand(1234)

    for acc in 0:5:100
        noTokenFixed = mean([simChallenge(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:30])[1]
        noTokenDiv = mean([simChallenge(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:30])[1]
        tokenFixed = mean([simToken(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:30])[1]
        tokenDiv = mean([simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:30])[1]
        println("$acc, $noTokenFixed, $noTokenDiv, $tokenFixed, $tokenDiv")
    end
end

function tokensAndDiversificationsEffects()
    srand(1234)
    divEffects = []
    tokenEffect = []
    tokenDivEffects = []
    for acc in 0:5:100
        noTokenFixed = mean([simChallenge(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:30])[1]
        noTokenDiv = mean([simChallenge(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:30])[1]
        tokenFixed = mean([simToken(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:30])[1]
        tokenDiv = mean([simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:30])[1]

        divEffect = mean([tokenDiv - tokenFixed, noTokenDiv - noTokenFixed])
        tokenEffect = mean([tokenDiv - noTokenDiv, tokenFixed - noTokenFixed])
        tokenDivEffect = tokenDiv - noTokenFixed
        println("$acc, $divEffect, $tokenEffect, $tokenDivEffect")
    end
end

function compareEfficiencyByAccuracy()
    for acc in 0:5:100
        noToken = [simChallenge(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean])[1] for i in 1:30]
        token = [simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean])[1] for i in 1:30]
        boost = mean(token) - mean(noToken)
        test = pvalue(UnequalVarianceTTest(token, noToken))
        significant = test < 0.05
        println("$acc, $boost, $test, $significant")
    end
end

function efficiencyArea()
    for noAgents in 10:10:200
        for noSteps in 100:100:2000
            noToken = [simChallenge(noSteps, setupRandomAgents(noAgents, 50, 20), [benchmarkRegistryMean])[1] for i in 1:10]
            token = [simToken(noSteps, setupRandomAgents(noAgents, 50, 20), [benchmarkRegistryMean])[1] for i in 1:10]
            boost = mean(token) - mean(noToken)
            println("$noSteps, $noAgents, $boost")
        end
    end
end

function expertsInnerCirleSize()
    for expertCount in 1:1:50
        controlLow= mean([simChallenge(1000, setupAgentsWithFixedAccuracy(100, 20), [benchmarkRegistryMean])[1] for i in 1:20])
        expertTokens = mean([simToken(1000, setupMixedAgents(100-expertCount, 20, expertCount, 100), [benchmarkRegistryMean])[1] for i in 1:20])
        expertNoTokens = mean([simChallenge(1000, setupMixedAgents(100-expertCount, 20, expertCount, 100), [benchmarkRegistryMean])[1] for i in 1:20])
        controlHigh = mean([simChallenge(1000, setupAgentsWithFixedAccuracy(100, 100), [benchmarkRegistryMean])[1] for i in 1:20])
        println("$expertCount, $controlLow, $expertTokens, $expertNoTokens, $controlHigh")
    end
end

function compareRedistribution()
    for acc in 0:5:100
        challengerOnly = [simToken(1000, setupRandomAgents(100, acc, 20), onlyChallengerRewardRedistribution, [benchmarkRegistryMean])[1] for i in 1:20]
        punishment = [simToken(1000, setupRandomAgents(100, acc, 20), punishmentRedistribution, [benchmarkRegistryMean])[1] for i in 1:20]
        reward = [simToken(1000, setupRandomAgents(100, acc, 20), rewardRedistribution, [benchmarkRegistryMean])[1] for i in 1:20]
        punishmentAndReward = [simToken(1000, setupRandomAgents(100, acc, 20), punishmentAndRewardRedistribution, [benchmarkRegistryMean])[1] for i in 1:20]
        pBoost = mean(punishment) - mean(challengerOnly)
        rBoost = mean(reward) - mean(challengerOnly)
        prBoost = mean(punishmentAndReward) - mean(challengerOnly)
        # test = pvalue(UnequalVarianceTTest(full, challengerOnly))
        # significant = test < 0.05
        println("$acc, $pBoost, $rBoost, $prBoost")
    end
end

compareRedistribution()
