

using HypothesisTests

noToken = [runDivSimulation(5000, 50, 65, 20) for i in 1:20]
v = var(noToken)
m = mean(noToken)

println("Var: $v Mean: $m")



token = [runTokenSimulation(5000, 50, 65, 20) for i in 1:20]
vt = var(token)
mt = mean(token)

println("Token Var: $vt Mean: $mt")

t = UnequalVarianceTTest(noToken, token)

println(t)
