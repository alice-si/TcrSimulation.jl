facts("Testing creation of fixed accuracy agents pool") do
    agents = TcrCore.setupAgentsWithFixedAccuracy(3, 50)
    @fact length(agents) --> 3
    @fact agents[1].accuracy --> 50
    @fact agents[2].accuracy --> 50
    @fact agents[3].accuracy --> 50
end

facts("Testing creation of low diversified accuracy agents pool") do
    agents = TcrCore.setupRandomAgents(MersenneTwister(1234), 5, 50, 10)
    @fact length(agents) --> 5
    @fact agents[1].accuracy --> 58
    @fact agents[2].accuracy --> 40
    @fact agents[3].accuracy --> 45
    @fact agents[4].accuracy --> 40
    @fact agents[5].accuracy --> 58
end

facts("Testing creation of high diversified accuracy agents pool") do
    agents = TcrCore.setupRandomAgents(MersenneTwister(1234), 5, 50, 20)
    @fact length(agents) --> 5
    @fact agents[1].accuracy --> 67
    @fact agents[2].accuracy --> 31
    @fact agents[3].accuracy --> 40
    @fact agents[4].accuracy --> 31
    @fact agents[5].accuracy --> 67
end

facts("Testing candidate evaluation by a perfect agent") do
    agent = Agent(100)
    @fact TcrCore.evaluateCandidateByAgent(rng, 30, agent) --> 30
    @fact TcrCore.evaluateCandidateByAgent(rng, 50, agent) --> 50
    @fact TcrCore.evaluateCandidateByAgent(rng, 80, agent) --> 80
end

facts("Testing candidate evaluation by a high accuracy agent") do
    agent = Agent(80)
    @fact TcrCore.evaluateCandidateByAgent(MersenneTwister(1234), 30, agent) --> 38.67347201951246
    @fact TcrCore.evaluateCandidateByAgent(MersenneTwister(1234), 50, agent) --> 58.67347201951246
    @fact TcrCore.evaluateCandidateByAgent(MersenneTwister(1234), 80, agent) --> 88.67347201951246
end
#
# facts("Testing candidate evaluation by a medium accuracy agent") do
#     agent = Agent(50)
#     @fact TcrCore.evaluateCandidateByAgent(rng, 30, agent) --> 76.31957394313864
#     @fact TcrCore.evaluateCandidateByAgent(rng, 50, agent) --> 70.694085795423
#     @fact TcrCore.evaluateCandidateByAgent(rng, 80, agent) --> 82.75240315805439
# end
