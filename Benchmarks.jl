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

end
