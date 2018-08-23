module Benchmarks

    function topMean(history, count)
        sorted = mean(sort(history, rev=true)[1:count])
    end

    function top10Mean(history)
        sorted = mean(sort(history, rev=true)[1:10])
    end

    function evaluate(history, registry)
        top10Mean(history) - mean(registry)
    end

    function score(registry)
        mean(registry)
    end

    function meanAccuracy(agents)
        accs = []
        for agent in agents
            push!(accs, agent.accuracy)
        end
        meanAccuracy = mean(accs)
        return meanAccuracy
    end

    function effectiveAccuracy(agents)
        eAcc = []
        count = 0
        for agent in agents
            if agent.balance > 0
                push!(eAcc, agent.accuracy)
                count = count + 1
            end
        end
        effective = mean(eAcc)
        normal = Benchmarks.meanAccuracy(agents)
        boost = effective-normal;
        println("Count: $count Accuracy boost: $boost")
        return boost
    end


end
