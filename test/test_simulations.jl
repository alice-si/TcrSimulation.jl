using FactCheck



facts("Testing simple simulation with fixed agents and no challenge") do
    rng = MersenneTwister(1234);
    results = TcrSimulations.simFixedAgentsNoChallenge(rng, 1, 1, 100, [TcrSimulations.benchmarkRegistryMean])
    print(results)
    #@fact results --> TODO: define seed
end
