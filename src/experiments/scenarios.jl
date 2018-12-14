
function compareRegistryQuality(rng)
    for acc in 40:2:60
        noChallenge = mean([simFixedAgentsNoChallenge(rng, 1000, 50, acc, [benchmarkRegistryMean]) for i in 1:20])[1]
        fixedChallenge = mean([simFixedAgentsWithChallenge(rng, 1000, 50, acc, [benchmarkRegistryMean]) for i in 1:20])[1]
        div10Challenge = mean([simDiversifiedAgentsWithChallenge(rng, 1000, 50, acc, 10, [benchmarkRegistryMean]) for i in 1:20])[1]
        div20Challenge = mean([simDiversifiedAgentsWithChallenge(rng, 1000, 50, acc, 20, [benchmarkRegistryMean]) for i in 1:20])[1]
        binaryToken = mean([simWithBinTokens(rng, 1000, 50, acc, 20, [benchmarkRegistryMean]) for i in 1:20])[1]
        proRataToken = mean([simWithProRataTokens(rng, 1000, 50, acc, 20, [benchmarkRegistryMean]) for i in 1:20])[1]

        # token = mean([binaryTokenChallenge(1000, 50, acc, 10, [Benchmarks.registryMean]) for i in 1:20])[1]
        println("$acc, $noChallenge, $fixedChallenge, $div10Challenge, $div20Challenge, $binaryToken, $proRataToken")
    end
end

rng = MersenneTwister(1234);
compareRegistryQuality(rng)
