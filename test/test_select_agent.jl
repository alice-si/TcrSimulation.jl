@testset "random agent selection" begin
    agents = TcrSimulation.setupAgentsWithFixedAccuracy(1, 100)
    onlyAgent = agents[1]
    @test TcrSimulation.selectRandomAgent(agents) == onlyAgent
end
