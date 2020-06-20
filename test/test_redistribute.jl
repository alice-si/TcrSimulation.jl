
@testset "only challenger reward - challenge accepted" begin
    Random.seed!(1234)
    challenger = Agent(100)
    other = Agent(100)
    result = [false, [other], [challenger]]
    TcrSimulation.onlyChallengerRewardRedistribution(result, challenger, 10)
    @test challenger.balance == 70 #Received double deposit
end

@testset "punishment redistribution" begin
    Random.seed!(1234)
    challenger = Agent(100)
    pro = [Agent(100), Agent(100)]
    cons = [Agent(100), Agent(100)]
    result = [false, pro, cons]
    TcrSimulation.punishmentRedistribution(result, challenger, 10)
    @test challenger.balance == 70 #Received double deposit
    @test pro[1].balance == 45
    @test pro[2].balance == 45
    @test cons[1].balance == 50
    @test cons[2].balance == 50
end

@testset "reward redistribution" begin
    Random.seed!(1234)
    challenger = Agent(100)
    pro = [Agent(100), Agent(100)]
    cons = [Agent(100), Agent(100)]
    result = [false, pro, cons]
    TcrSimulation.rewardRedistribution(result, challenger, 10)
    @test challenger.balance == 60 #Received double deposit
    @test pro[1].balance == 50
    @test pro[2].balance == 50
    @test cons[1].balance == 55
    @test cons[2].balance == 55
end

@testset "punishment & reward redistribution" begin
    Random.seed!(1234)
    challenger = Agent(100)
    pro = [Agent(100), Agent(100)]
    cons = [Agent(100), Agent(100)]
    result = [false, pro, cons]
    TcrSimulation.punishmentAndRewardRedistribution(result, challenger, 10)
    @test challenger.balance == 70 #Received double deposit
    @test pro[1].balance == 45
    @test pro[2].balance == 45
    @test cons[1].balance == 55
    @test cons[2].balance == 55
end
