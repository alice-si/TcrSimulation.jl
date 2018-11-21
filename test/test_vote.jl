using FactCheck

facts("Testing simple vote with single voter and an empty registry") do
    agents = TcrSimulations.setupAgentsWithFixedAccuracy(1, 100)
    @fact TcrSimulations.simpleVote([], 30, agents)[1] --> true
end

facts("Testing simple vote with single voter and one-item registry") do
    agents = TcrSimulations.setupAgentsWithFixedAccuracy(1, 100)
    @fact TcrSimulations.simpleVote([50], 30, agents)[1] --> false
    @fact TcrSimulations.simpleVote([50], 70, agents)[1] --> true
end
