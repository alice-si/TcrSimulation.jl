@testset "creation of fixed accuracy agents pool" begin
    agents = TcrSimulation.setupAgentsWithFixedAccuracy(3, 50)
    @test length(agents) == 3
    @test agents[1].accuracy == 50
    @test agents[2].accuracy == 50
    @test agents[3].accuracy == 50
end

@testset "creation of low diversified accuracy agents pool" begin
    Random.seed!(1234)
    agents = TcrSimulation.setupRandomAgents(5, 50, 10)
    @test length(agents) == 5
    @test agents[1].accuracy == 58
    @test agents[2].accuracy == 40
    @test agents[3].accuracy == 45
    @test agents[4].accuracy == 40
    @test agents[5].accuracy == 58
end

@testset "creation of high diversified accuracy agents pool" begin
    Random.seed!(1234)
    agents = TcrSimulation.setupRandomAgents(5, 50, 20)
    @test length(agents) == 5
    @test agents[1].accuracy == 67
    @test agents[2].accuracy == 31
    @test agents[3].accuracy == 40
    @test agents[4].accuracy == 31
    @test agents[5].accuracy == 67
end

@testset "candidate evaluation by a perfect agent" begin
    Random.seed!(1234)
    agent = Agent(100)
    @test TcrSimulation.evaluateCandidateByAgent(30, agent) == 30
    @test TcrSimulation.evaluateCandidateByAgent(50, agent) == 50
    @test TcrSimulation.evaluateCandidateByAgent(80, agent) == 80
end

@testset "candidate evaluation by a high accuracy agent" begin
    Random.seed!(1234)
    agent = Agent(80)
    @test TcrSimulation.evaluateCandidateByAgent(30, agent) == 35.78231467967497
    @test TcrSimulation.evaluateCandidateByAgent(50, agent) == 56.011625439045446
    @test TcrSimulation.evaluateCandidateByAgent(80, agent) == 83.29652502336155
end

@testset "candidate evaluation by a medium accuracy agent" begin
    Random.seed!(1234)
    agent = Agent(50)
    @test TcrSimulation.evaluateCandidateByAgent(30, agent) == 44.45578669918743
    @test TcrSimulation.evaluateCandidateByAgent(50, agent) == 65.02906359761361
    @test TcrSimulation.evaluateCandidateByAgent(80, agent) == 88.2413125584039
end
