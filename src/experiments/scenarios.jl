
function compareRegistryQuality(rng)
    for acc in 0:10:100
        fixedNoChallenge = mean([simFixedAgentsNoChallenge(rng, 1000, 50, acc, [benchmarkRegistryMean]) for i in 1:20])[1]
        # token = mean([binaryTokenChallenge(1000, 50, acc, 10, [Benchmarks.registryMean]) for i in 1:20])[1]
        println("$acc, $fixedNoChallenge")
    end
end
