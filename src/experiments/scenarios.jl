
function compareRegistryQuality(rng)
    for acc in 50:10:100
        a = mean([simFixedAgentsNoChallenge(rng, 1000, 50, acc, [benchmarkRegistryMean]) for i in 1:20])[1]
        b = mean([simFixedAgentsWithChallenge(rng, 1000, 50, acc, [benchmarkRegistryMean]) for i in 1:20])[1]
        # token = mean([binaryTokenChallenge(1000, 50, acc, 10, [Benchmarks.registryMean]) for i in 1:20])[1]
        println("$acc, $a, $b")
    end
end

rng = MersenneTwister(1234);
compareRegistryQuality(rng);
