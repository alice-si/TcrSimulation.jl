for steps in 50:50:100
    results = mean([binaryTokenChallenge(steps, 50, 50, 20, [Benchmarks.accuracyBoost, Benchmarks.accuracyBalanceCorrelation, Benchmarks.registryMean]) for i in 1:40])
    boost = results[1]
    correlation = results[2]
    registry = results[3]
    println("$steps, $boost, $correlation, $registry")
end
