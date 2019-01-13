
facts("Testing simple vote with single voter") do
    srand(1234)
    agents = [Agent(100)]
    @fact TcrCore.simpleVote(0, 30, agents) --> [true, agents, []]
    @fact TcrCore.simpleVote(50, 30, agents) --> [false, [], agents]
end

facts("Testing simple vote with diversified voters") do
    srand(1234)
    highAccAgent = Agent(100)
    lowAccAgent = Agent(20)
    agents = [lowAccAgent, highAccAgent]

    @fact TcrCore.simpleVote(50, 50, agents) --> [true, agents, []]
    @fact TcrCore.simpleVote(50, 40, agents) --> [false, [lowAccAgent], [highAccAgent]]
    @fact TcrCore.simpleVote(50, 0, agents) --> [false, [], agents]
end

facts("Testing binary token vote with diversified voters") do
    srand(1234)
    highAccAgent = Agent(100)
    lowAccAgent = Agent(20)
    agents = [lowAccAgent, highAccAgent]

    #Both agents vote
    @fact TcrCore.binaryTokenVote(50, 40, agents) --> [false, [lowAccAgent], [highAccAgent]]

    #Only high accuracy votes
    lowAccAgent.balance = 0
    @fact TcrCore.binaryTokenVote(50, 40, agents) --> [false, [], [highAccAgent]]

    #Only high accuracy votes
    lowAccAgent.balance = 50
    highAccAgent.balance = 0
    @fact TcrCore.binaryTokenVote(50, 40, agents) --> [true, [lowAccAgent], []]
end

facts("Testing pro-rata token vote with diversified voters") do
    srand(1234)
    highAccAgent = Agent(100)
    lowAccAgent = Agent(20)
    agents = [lowAccAgent, highAccAgent]

    #Two agents with the same amount of tokens
    @fact TcrCore.proRataTokenVote(50, 40, agents) --> [false, [lowAccAgent], [highAccAgent]]

    #Agents differs in tokens
    lowAccAgent.balance = 51
    @fact TcrCore.proRataTokenVote(50, 40, agents) --> [true, [lowAccAgent], [highAccAgent]]

    #One agent has got more tokens than two others in total
    srand(1234)
    highAccAgent.balance = 50
    lowAccAgent.balance = 101
    @fact TcrCore.proRataTokenVote(50, 40, [lowAccAgent, highAccAgent, highAccAgent]) --> [true, [lowAccAgent], [highAccAgent, highAccAgent]]
end
