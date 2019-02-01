
facts("Testing only challenger reward - challenge accepted") do
    srand(1234)
    challenger = Agent(100)
    other = Agent(100)
    result = [false, [other], [challenger]]
    TcrCore.onlyChallengerRewardRedistribution(result, challenger, 10)
    @fact challenger.balance --> 70 #Received double deposit
end

facts("Testing punishment redistribution") do
    srand(1234)
    challenger = Agent(100)
    pro = [Agent(100), Agent(100)]
    cons = [Agent(100), Agent(100)]
    result = [false, pro, cons]
    TcrCore.punishmentRedistribution(result, challenger, 10)
    @fact challenger.balance --> 70 #Received double deposit
    @fact pro[1].balance --> 45
    @fact pro[2].balance --> 45
    @fact cons[1].balance --> 50
    @fact cons[2].balance --> 50
end

facts("Testing reward redistribution") do
    srand(1234)
    challenger = Agent(100)
    pro = [Agent(100), Agent(100)]
    cons = [Agent(100), Agent(100)]
    result = [false, pro, cons]
    TcrCore.rewardRedistribution(result, challenger, 10)
    @fact challenger.balance --> 60 #Received double deposit
    @fact pro[1].balance --> 50
    @fact pro[2].balance --> 50
    @fact cons[1].balance --> 55
    @fact cons[2].balance --> 55
end

facts("Testing punishment & reward redistribution") do
    srand(1234)
    challenger = Agent(100)
    pro = [Agent(100), Agent(100)]
    cons = [Agent(100), Agent(100)]
    result = [false, pro, cons]
    TcrCore.punishmentAndRewardRedistribution(result, challenger, 10)
    @fact challenger.balance --> 70 #Received double deposit
    @fact pro[1].balance --> 45
    @fact pro[2].balance --> 45
    @fact cons[1].balance --> 55
    @fact cons[2].balance --> 55
end
