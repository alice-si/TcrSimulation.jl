facts("Testing simple vote with single voter and an empty registry") do
    agents = TcrCore.setupAgentsWithFixedAccuracy(1, 100)
    @fact TcrCore.simpleVote([], 30, agents)[1] --> true
end

facts("Testing simple vote with single voter and one-item registry") do
    agents = TcrCore.setupAgentsWithFixedAccuracy(1, 100)
    @fact TcrCore.simpleVote([50], 30, agents)[1] --> false
    @fact TcrCore.simpleVote([50], 70, agents)[1] --> true
end
