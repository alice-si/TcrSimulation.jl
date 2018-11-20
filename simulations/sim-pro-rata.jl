for steps in 50:500:10000
    binary = mean([binaryTokenChallenge(steps, 50, 60, 10, [Benchmarks.registryMean, Benchmarks.activeAgents, Benchmarks.accuracyBoost, Benchmarks.weightedAccuracyBoost, Benchmarks.accuracyBalanceCorrelation]) for i in 1:20])
    pro = mean([proRataTokenChallenge(steps, 50, 60, 10, [Benchmarks.registryMean, Benchmarks.activeAgents, Benchmarks.accuracyBoost, Benchmarks.weightedAccuracyBoost, Benchmarks.accuracyBalanceCorrelation]) for i in 1:20])
    println("$steps, $binary, $pro")
end

proRataTokenChallenge(100, 20, 60, 10, [Benchmarks.registryMean, Benchmarks.activeAgents, Benchmarks.accuracyBoost, Benchmarks.weightedAccuracyBoost, Benchmarks.accuracyBalanceCorrelation])
