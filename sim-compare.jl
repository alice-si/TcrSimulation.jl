
for acc in 0:2:100
    noToken = mean([highDiversityWithChallenge(1000, 50, acc, 10, Benchmarks.registryMean) for i in 1:20])
    token = mean([binaryTokenChallenge(1000, 50, acc, 10, Benchmarks.registryMean) for i in 1:20])
    println("$acc, $noToken, $token")
end
