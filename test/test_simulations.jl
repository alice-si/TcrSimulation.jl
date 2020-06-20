@testset "simple simulation with fixed agents and no challenge" begin
    Random.seed!(1234)
    results = TcrSimulation.simSimple(1000, setupAgentsWithFixedAccuracy(100, 50), [TcrSimulation.benchmarkRegistryMean])
    print(results)
    @test results[1] == 72.20784862274684
end
