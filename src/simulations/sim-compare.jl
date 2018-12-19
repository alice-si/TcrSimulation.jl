
#Accuracy -> efficiency
for acc in 0:2:100
    noToken = mean([diversityWithChallenge(1000, 50, acc, 10, [Benchmarks.registryMean]) for i in 1:20])[1]
    token = mean([binaryTokenChallenge(1000, 50, acc, 10, [Benchmarks.registryMean]) for i in 1:20])[1]
    println("$acc, $noToken, $token")
end



#Agents of steps -> efficiency
for agents in 10:10:200
    noToken = mean([diversityWithChallenge(1000, agents, 50, 20, [Benchmarks.registryMean]) for i in 1:20])[1]
    token = mean([binaryTokenChallenge(1000, agents, 50, 20, [Benchmarks.registryMean]) for i in 1:20])[1]
    println("$agents, $noToken, $token")
end


#Number of steps -> efficiency
for steps in 2000:100:3000
    noToken = mean([diversityWithChallenge(steps, 50, 50, 20, [Benchmarks.registryMean]) for i in 1:20])[1]
    token = mean([binaryTokenChallenge(steps, 50, 50, 20, [Benchmarks.registryMean]) for i in 1:20])[1]
    println("$steps, $noToken, $token")
end

for acc in 0:10:100
    token = mean([binaryTokenChallenge(1000, 100, acc, 20, [Benchmarks.registryMean]) for i in 1:20])[1]
    println("$acc, $token")
end
