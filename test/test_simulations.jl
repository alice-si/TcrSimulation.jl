facts("Testing simple simulation with fixed agents and no challenge") do
    srand(1234)
    results = TcrCore.simSimple(1000, setupAgentsWithFixedAccuracy(100, 50), [TcrCore.benchmarkRegistryMean])
    print(results)
    @fact results[1] --> 72.20784862274684
end
