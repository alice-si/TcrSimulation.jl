"""
Calculates the mean quality of the items in the given registry
"""
function benchmarkRegistryMean(registry, agents)
    mean(registry)
end


"""
Calculates the mean quality of the top 10 items in the given registry
"""
function top10Mean(history)
    sorted = mean(sort(history, rev=true)[1:10])
end


"""
Calculates the mean quality of the top X(count) items in the given registry
"""
function topMean(history, count)
    sorted = mean(sort(history, rev=true)[1:count])
end


"""
Calculates the mean accurancy of a group of agents
"""
function meanAccuracy(registry, agents)
    accs = []
    for agent in agents
        push!(accs, agent.accuracy)
    end
    meanAccuracy = mean(accs)
    return meanAccuracy
end


"""
Calculates the number of agents possesing tokens thus being able to stake
them to participate in challenges and votings
"""
function activeAgents(registry, agents)
    length(filter(a -> a.balance > 0, agents))
end


"""
Calculates the difference in accurancy of agents who posses tokens and those
who does not hold any tokens
"""
function benchmarkAccuracyBoost(registry, agents)
    eAcc = []
    count = 0
    for agent in agents
        if agent.balance > 0
            push!(eAcc, agent.accuracy)
            count = count + 1
        end
    end
    effective = mean(eAcc)
    normal = meanAccuracy(registry, agents)
    boost = effective-normal
end


"""
Calculates the difference in accurancy of agents weighted by the number of tokens
they posses
"""
function benchmarkWeightedAccuracyBoost(registry, agents)
    count = 0
    eAcc = 0;
    for agent in agents
        if agent.balance > 0
            eAcc += agent.balance * agent.accuracy
            count += agent.balance
        end
    end
    effective = eAcc/count
    normal = meanAccuracy(registry, agents)
    boost = effective-normal
end


"""
Calculates the correlation between agents accuracy and balance
"""
function benchmarkAccuracyBalanceCorrelation(registry, agents)
    a = [agent.accuracy for agent in agents]
    b = [agent.balance for agent in agents]
    corspearman(a, b)
end


"""
Calculates the gini coefficient - how equally tokens are distributed among agents
"""
function gini(registry, agents)
    x = [agent.balance for agent in agents]
    n = length(x)
    xx = sort(x)
    2*(sum(collect(1:n).*xx))/(n*sum(xx))-1
end
