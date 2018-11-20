include("./Benchmarks.jl")

import Benchmarks

using HypothesisTests

noToken = [lowDiversityWithChallenge(1000, 50, 70, Benchmarks.registryMean) for i in 1:20]
v = var(noToken)
m = mean(noToken)

println("Var: $v Mean: $m")



token = [binaryTokenChallenge(1000, 50, 70, Benchmarks.registryMean) for i in 1:20]
vt = var(token)
mt = mean(token)

println("Var: $vt Mean: $mt")

t = UnequalVarianceTTest(noToken, token)

println(t)
