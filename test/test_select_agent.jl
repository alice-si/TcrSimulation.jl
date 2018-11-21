using FactCheck

facts("Testing random agent selection") do
    agents = TcrSimulations.setupAgentsWithFixedAccuracy(1, 100)
    onlyAgent = agents[1]
    @fact TcrSimulations.selectRandomAgent(agents) --> onlyAgent
end
