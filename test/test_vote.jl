
@testset "simple vote with single voter" begin
    Random.seed!(1234)
    agents = [Agent(100)]
    @test TcrSimulation.simpleVote(0, 30, agents) == [true, agents, []]
    @test TcrSimulation.simpleVote(50, 30, agents) == [false, [], agents]
end

@testset "simple vote with diversified voters" begin
    Random.seed!(1234)
    highAccAgent = Agent(100)
    lowAccAgent = Agent(20)
    agents = [lowAccAgent, highAccAgent]

    @test TcrSimulation.simpleVote(50, 50, agents) == [true, agents, []]
    @test TcrSimulation.simpleVote(50, 40, agents) == [false, [lowAccAgent], [highAccAgent]]
    @test TcrSimulation.simpleVote(50, 0, agents) == [false, [], agents]
end

@testset "binary token vote with diversified voters" begin
    Random.seed!(1234)
    highAccAgent = Agent(100)
    lowAccAgent = Agent(20)
    agents = [lowAccAgent, highAccAgent]

    #Both agents vote
    @test TcrSimulation.binaryTokenVote(50, 40, agents) == (false, [lowAccAgent], [highAccAgent])

    #Only high accuracy votes
    lowAccAgent.balance = 0
    @test TcrSimulation.binaryTokenVote(50, 40, agents) == (false, [], [highAccAgent])

    #Only high accuracy votes
    lowAccAgent.balance = 50
    highAccAgent.balance = 0
    @test TcrSimulation.binaryTokenVote(50, 40, agents) == (true, [lowAccAgent], [])
end

@testset "pro-rata token vote with diversified voters" begin
    Random.seed!(1234)
    highAccAgent = Agent(100)
    lowAccAgent = Agent(20)
    agents = [lowAccAgent, highAccAgent]

    #Two agents with the same amount of tokens
    @test TcrSimulation.proRataTokenVote(50, 40, agents) == (false, [lowAccAgent], [highAccAgent])

    #Agents differs in tokens
    lowAccAgent.balance = 51
    @test TcrSimulation.proRataTokenVote(50, 40, agents) == (true, [lowAccAgent], [highAccAgent])

    #One agent has got more tokens than two others in total
    Random.seed!(1234)
    highAccAgent.balance = 50
    lowAccAgent.balance = 101
    @test TcrSimulation.proRataTokenVote(50, 40, [lowAccAgent, highAccAgent, highAccAgent]) == (true, [lowAccAgent], [highAccAgent, highAccAgent])
end
