facts("Testing random agent selection") do
    agents = TcrCore.setupAgentsWithFixedAccuracy(1, 100)
    onlyAgent = agents[1]
    @fact TcrCore.selectRandomAgent(agents) --> onlyAgent
end
