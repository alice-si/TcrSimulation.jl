include("./simulations.jl")

for acc in 0:5:100
    noToken = mean([diversityWithChallenge(1000, 50, acc, 10, [Benchmarks.registryMean]) for i in 1:10])[1]
    token = mean([binaryTokenChallenge(1000, 50, acc, 10, [Benchmarks.registryMean]) for i in 1:10])[1]
    println("$acc, $noToken, $token")
end
