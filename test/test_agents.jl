facts("Testing creation of fixed accuracy agents pool") do
    agents = TcrCore.setupAgentsWithFixedAccuracy(3, 50)
    @fact length(agents) --> 3
    @fact agents[1].accuracy --> 50
    @fact agents[2].accuracy --> 50
    @fact agents[3].accuracy --> 50
end

facts("Testing creation of low diversified accuracy agents pool") do
    srand(1234)
    agents = TcrCore.setupRandomAgents(5, 50, 10)
    @fact length(agents) --> 5
    @fact agents[1].accuracy --> 58
    @fact agents[2].accuracy --> 40
    @fact agents[3].accuracy --> 45
    @fact agents[4].accuracy --> 40
    @fact agents[5].accuracy --> 58
end

facts("Testing creation of high diversified accuracy agents pool") do
    srand(1234)
    agents = TcrCore.setupRandomAgents(5, 50, 20)
    @fact length(agents) --> 5
    @fact agents[1].accuracy --> 67
    @fact agents[2].accuracy --> 31
    @fact agents[3].accuracy --> 40
    @fact agents[4].accuracy --> 31
    @fact agents[5].accuracy --> 67
end

facts("Testing candidate evaluation by a perfect agent") do
    srand(1234)
    agent = Agent(100)
    @fact TcrCore.evaluateCandidateByAgent(30, agent) --> 30
    @fact TcrCore.evaluateCandidateByAgent(50, agent) --> 50
    @fact TcrCore.evaluateCandidateByAgent(80, agent) --> 80
end

facts("Testing candidate evaluation by a high accuracy agent") do
    srand(1234)
    agent = Agent(80)
    @fact TcrCore.evaluateCandidateByAgent(30, agent) --> 35.78231467967497
    @fact TcrCore.evaluateCandidateByAgent(50, agent) --> 56.011625439045446
    @fact TcrCore.evaluateCandidateByAgent(80, agent) --> 83.29652502336155
end

facts("Testing candidate evaluation by a medium accuracy agent") do
    srand(1234)
    agent = Agent(50)
    @fact TcrCore.evaluateCandidateByAgent(30, agent) --> 44.45578669918743
    @fact TcrCore.evaluateCandidateByAgent(50, agent) --> 65.02906359761361
    @fact TcrCore.evaluateCandidateByAgent(80, agent) --> 88.2413125584039
end
