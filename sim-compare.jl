

using HypothesisTests

noToken = [runDivSimulation(1000, 50, 70, 10) for i in 1:30]
v = var(noToken)
m = mean(noToken)

println("Var: $v Mean: $m")



token = [runTokenSimulation(1000, 50, 70, 10) for i in 1:500]
vt = var(token)
mt = mean(token)

println("Var: $vt Mean: $mt")
#
# t = UnequalVarianceTTest(noToken, token)
#
# println(t)
