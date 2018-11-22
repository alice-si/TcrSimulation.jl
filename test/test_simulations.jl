facts("Testing simple simulation with fixed agents and no challenge") do
    rng = MersenneTwister(1234);
    results = TcrCore.simFixedAgentsNoChallenge(rng, 1, 1, 100, [TcrExp.benchmarkRegistryMean])
    print(results)
    @fact results[1] --> 67.34694403902492
end
