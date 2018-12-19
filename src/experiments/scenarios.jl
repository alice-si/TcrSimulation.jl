function simSimpleWithDifferentAgents()
    srand(1234)
    for acc in 0:10:100
        fixed = mean([simSimple(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:10])[1]
        div10 = mean([simSimple(1000, setupRandomAgents(100, acc, 10), [benchmarkRegistryMean]) for i in 1:10])[1]
        div20 = mean([simSimple(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:10])[1]
        mixed = mean([simSimple(1000, setupMixedAgents(100-acc, 0, acc, 100), [benchmarkRegistryMean]) for i in 1:10])[1]
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
        mixed = mean([simToken(1000, setupMixedAgents(100-acc, 0, acc, 100), [benchmarkRegistryMean]) for i in 1:10])[1]

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

function compareEfficiency()
    for acc in 0:5:100
        noToken = [simChallenge(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean])[1] for i in 1:10]
        token = [simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean])[1] for i in 1:10]
        boost = mean(token) - mean(noToken)
        test = pvalue(UnequalVarianceTTest(token, noToken))
        significant = test < 0.05
        println("$acc, $boost, $test, $significant")
    end
end

function manipulatingNoAgents(rng)
    for noAgents in 10:10:200
        noToken = [simDiversifiedAgentsWithChallenge(rng, 1000, noAgents, 50, 20, [benchmarkRegistryMean])[1] for i in 1:10]
        token = [simWithProRataTokens(rng, 1000, noAgents, 50, 20, [benchmarkRegistryMean])[1] for i in 1:10]
        boost = mean(token) - mean(noToken)
        println("$noAgents, $boost")
    end
end

function manipulatingNoSteps(rng)
    for noSteps in 100:100:2000
        noToken = [simDiversifiedAgentsWithChallenge(rng, noSteps, 100, 50, 20, [benchmarkRegistryMean])[1] for i in 1:10]
        token = [simWithProRataTokens(rng, noSteps, 100, 50, 20, [benchmarkRegistryMean])[1] for i in 1:10]
        boost = mean(token) - mean(noToken)
        println("$noSteps, $boost")
    end
end

function efficiencyArea(rng)
    for noAgents in 10:10:200
        for noSteps in 100:100:2000
            noToken = [simDiversifiedAgentsWithChallenge(rng, noSteps, noAgents, 50, 20, [benchmarkRegistryMean])[1] for i in 1:10]
            token = [simWithProRataTokens(rng, noSteps, noAgents, 50, 20, [benchmarkRegistryMean])[1] for i in 1:10]
            boost = mean(token) - mean(noToken)
            println("$noSteps, $noAgents, $boost")
        end
    end
end

function accuracyAndBalanceCorrelation(rng)
    for acc in 0:10:100
        correlation = mean([simWithProRataTokens(rng, 1000, 50, acc, 20, [benchmarkAccuracyBalanceCorrelation]) for i in 1:10])[1]
        println("$acc, $correlation")
    end
end

# function tokenEfficiencyWindow()
#     srand(1234)
#     for acc in 0:10:100
#         noToken = mean([simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:10])[1]
#         token = mean([simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:10])[1]
#     end


compareEfficiency()
