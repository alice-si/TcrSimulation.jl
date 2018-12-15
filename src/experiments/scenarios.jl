
function compareRegistryQuality(rng)
    for acc in 10:10:100
        noChallenge = mean([simFixedAgentsNoChallenge(rng, 1000, 50, acc, [benchmarkRegistryMean]) for i in 1:20])[1]
        challenge = mean([simFixedAgentsWithChallenge(rng, 1000, 50, acc, [benchmarkRegistryMean]) for i in 1:20])[1]
        divAgents = mean([simDiversifiedAgentsWithChallenge(rng, 1000, 50, acc, 10, [benchmarkRegistryMean]) for i in 1:20])[1]
        token = mean([simWithProRataTokens(rng, 1000, 50, acc, 20, [benchmarkRegistryMean]) for i in 1:20])[1]

        println("$acc, $noChallenge, $challenge, $divAgents, $token")
    end
end

rng = MersenneTwister(1234);
compareRegistryQuality(rng)
