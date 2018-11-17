module Benchmarks
    using StatsBase

    function topMean(history, count)
        sorted = mean(sort(history, rev=true)[1:count])
    end

    function top10Mean(history)
        sorted = mean(sort(history, rev=true)[1:10])
    end

    function evaluate(history, registry)
        top10Mean(history) - mean(registry)
    end

    function registryMean(registry, agents)
        mean(registry)
    end

    function meanAccuracy(registry, agents)
        accs = []
        for agent in agents
            push!(accs, agent.accuracy)
        end
        meanAccuracy = mean(accs)
        return meanAccuracy
    end

    function accuracyBoost(registry, agents)
        eAcc = []
        count = 0
        for agent in agents
            if agent.balance > 0
                push!(eAcc, agent.accuracy)
                count = count + 1
            end
        end
        effective = mean(eAcc)
        normal = Benchmarks.meanAccuracy(registry, agents)
        boost = effective-normal
    end

    function activeAgents(registry, agents)
        length(filter(a -> a.balance > 0, agents))
    end

    function weightedAccuracyBoost(registry, agents)
        count = 0
        eAcc = 0;
        for agent in agents
            if agent.balance > 0
                eAcc += agent.balance * agent.accuracy
                count += agent.balance
            end
        end
        effective = eAcc/count
        normal = Benchmarks.meanAccuracy(registry, agents)
        boost = effective-normal
    end

    function accuracyBalanceCorrelation(registry, agents)
        a = [agent.accuracy for agent in agents]
        b = [agent.balance for agent in agents]
        # for ag in agents
        #    println(ag.balance)
        # end
        corspearman(a, b)
    end

    function gini(registry, agents)
        x = [agent.balance for agent in agents]
        n = length(x)
	    xx = sort(x)
	    2*(sum(collect(1:n).*xx))/(n*sum(xx))-1
    end



end
