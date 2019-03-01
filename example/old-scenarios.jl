function simSimpleWithDifferentAgents()
    srand(1234)
    for acc in 0:10:100
        fixed = mean([simSimple(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:10])[1]
        div10 = mean([simSimple(1000, setupRandomAgents(100, acc, 10), [benchmarkRegistryMean]) for i in 1:10])[1]
        div20 = mean([simSimple(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:10])[1]
        mixed = mean([simSimple(1000, setupMixedAgents(90, acc, 10, 100-acc), [benchmarkRegistryMean]) for i in 1:10])[1]
        println("$acc, $fixed, $div10, $div20, $mixed")
    end
end

function simChallengeWithDifferentAgents()
    srand(1234)
    for acc in 0:10:100
        fixed = mean([simChallenge(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:10])[1]
        div10 = mean([simChallenge(1000, setupRandomAgents(100, acc, 10), [benchmarkRegistryMean]) for i in 1:10])[1]
        div20 = mean([simChallenge(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:10])[1]
        mixed = mean([simChallenge(1000, setupMixedAgents(100-acc, 0, acc, 100), [benchmarkRegistryMean]) for i in 1:10])[1]

        println("$acc, $fixed, $div10, $div20, $mixed")
    end
end

function simTokenWithDifferentAgents()
    srand(1234)
    for acc in 0:10:100
        fixed = mean([simToken(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:10])[1]
        div10 = mean([simToken(1000, setupRandomAgents(100, acc, 10), [benchmarkRegistryMean]) for i in 1:10])[1]
        div20 = mean([simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:10])[1]
        mixed = mean([simToken(1000, setupMixedAgents(100-acc, 10, acc, 90), [benchmarkRegistryMean]) for i in 1:10])[1]

        println("$acc, $fixed, $div10, $div20, $mixed")
    end
end

function compareRegistryQualityOnDifferentSetups()
    for acc in 10:5:100
        noChallenge = mean([simSimple(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:10])[1]
        challenge = mean([simChallenge(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:10])[1]
        divAgents = mean([simChallenge(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:10])[1]
        token = mean([simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:10])[1]

        println("$acc, $noChallenge, $challenge, $divAgents, $token")
    end
end

"""
Accuracy is fixed to 50, Number of steps to 1000
"""
function manipulatingNoAgents()
    for noAgents in 10:10:200
        noToken = [simChallenge(1000, setupRandomAgents(noAgents, 50, 20), [benchmarkRegistryMean])[1] for i in 1:10]
        token = [simToken(1000, setupRandomAgents(noAgents, 50, 20), [benchmarkRegistryMean])[1] for i in 1:10]
        boost = mean(token) - mean(noToken)
        test = pvalue(UnequalVarianceTTest(token, noToken))
        significant = test < 0.05
        println("$noAgents, $boost, $test, $significant")
    end
end

"""
Accuracy is fixed to 50, Number of agents to 100
"""
function manipulatingNoSteps()
    for noSteps in 100:100:2000
        noToken = [simChallenge(noSteps, setupRandomAgents(100, 50, 20), [benchmarkRegistryMean])[1] for i in 1:10]
        token = [simToken(noSteps, setupRandomAgents(100, 50, 20), [benchmarkRegistryMean])[1] for i in 1:10]
        boost = mean(token) - mean(noToken)
        test = pvalue(UnequalVarianceTTest(token, noToken))
        significant = test < 0.05
        println("$noSteps, $boost, $test, $significant")
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

function accuracyAndBalanceCorrelation()
    for acc in 0:5:100
        results = mean([simToken(1500, setupRandomAgents(100, acc, 20), [benchmarkWeightedAccuracyBoost, benchmarkAccuracyBoost, benchmarkAccuracyBalanceCorrelation]) for i in 1:10])
        weighted = results[1]
        binary = results[2]
        correlation = results[3]
        println("$acc, $weighted, $binary, $correlation")
    end
end

function curationProcess()
    for noSteps in 50:50:2000
        results = mean([simToken(noSteps, setupMixedAgents(80, 0, 20, 100), [benchmarkWeightedAccuracyBoost, benchmarkAccuracyBalanceCorrelation, benchmarkRegistryMean]) for i in 1:30])
        boost = results[1]
        correlation = results[2]
        quality = results[3]
        println("$noSteps, $correlation, $quality")
    end
end
