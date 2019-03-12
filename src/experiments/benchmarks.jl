"""
Calculates the mean quality of the items in the given registry
"""
function benchmarkRegistryMean(registry, agents::Vector{Agent})
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
meanAccuracy(registry, agents::Vector{Agent}) = mean(getfield.(agents,:accuracy))


"""
Calculates the number of agents possesing tokens thus being able to stake
them to participate in challenges and votings
"""
function activeAgents(registry, agents::Vector{Agent})
    length(filter(a -> a.balance > 0, agents::Vector{Agent}))
end


"""
Calculates the difference in accurancy of agents who posses tokens and those
who does not hold any tokens
"""
function benchmarkAccuracyBoost(registry, agents::Vector{Agent})
    eAcc = Float64[]
    count = 0
    for agent in agents
        if agent.balance > 0
            push!(eAcc, agent.accuracy)
            count += 1
        end
    end
    effective = mean(eAcc)
    normal = meanAccuracy(registry, agents::Vector{Agent})
    boost = effective-normal
end


"""
Calculates the difference in accurancy of agents weighted by the number of tokens
they posses
"""
function benchmarkWeightedAccuracyBoost(registry, agents::Vector{Agent})
    countB = 0.0
    eAcc = 0;
    for agent in agents
        if agent.balance > 0
            eAcc += agent.balance * agent.accuracy
            countB += agent.balance
        end
    end
    effective = eAcc/countB
    normal = meanAccuracy(registry, agents::Vector{Agent})
    boost = effective-normal
end


"""
Calculates the correlation between agents accuracy and balance
"""
benchmarkAccuracyBalanceCorrelation(registry, agents::Vector{Agent}) =
    corspearman(getfield.(agents,:accuracy), getfield.(agents,:balance))



"""
Calculates the gini coefficient - how equally tokens are distributed among agents
"""
function gini(registry, agents::Vector{Agent})
    x = getfield.(agents,:balance)
    n = length(x)
    xx = sort(x)
    2*(sum(collect(1:n).*xx))/(n*sum(xx))-1
end
