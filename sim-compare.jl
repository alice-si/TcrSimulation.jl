

using HypothesisTests

noToken = [runSimulation(1000, 50, 70) for i in 1:100]
mnt = mean(noToken)

token = [runTokenSimulation(1000, 50, 70) for i in 1:100]
mt = mean(token)
println("No token: $mnt Token: $mt")

t = UnequalVarianceTTest(noToken, token)

println(t)
