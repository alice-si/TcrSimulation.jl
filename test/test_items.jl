@testset "item creation" begin
    Random.seed!(1234)
    @test TcrSimulation.getRegistryCandidate() == 67.34694403902492
    @test TcrSimulation.getRegistryCandidate() == 31.96512368286366
    @test TcrSimulation.getRegistryCandidate() == 40.110424929915325
end
