


for acc in 0:2:100
    results = mean([binaryTokenChallenge(1000, 50, acc, 20, [Benchmarks.accuracyBoost, Benchmarks.accuracyBalanceCorrelation]) for i in 1:40])
    boost = results[1]
    correlation = results[3]
    println("$acc, $boost, $correlation")
end
