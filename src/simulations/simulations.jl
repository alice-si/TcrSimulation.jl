

"""
The basic algorithm where on every step of the iteration
there is a new item applying to the registry that is being
collectively judged by agents during the majority voting
"""
function simSimple(num_of_steps, agents::Vector{Agent}, benchmarks)
    registry = Float64[]
    history = Float64[]

    for round in 1:num_of_steps
        application(registry, history, agents, simpleVote)
    end

    [b(registry, agents) for b in benchmarks]
end


"""
Apart from voting on a new appliations, a random agent challenges
the item that he consider the worst in the registry
"""
function simChallenge(num_of_steps, agents::Vector{Agent}, benchmarks)
    registry = Float64[]
    history = Float64[]

    for round in 1:num_of_steps
        application(registry, history, agents, simpleVote)
        challenge(registry, agents, 0, simpleVote, noneRedistribution)
    end

    [b(registry, agents) for b in benchmarks]
end


"""
This mode introduces a token as a mean to reward well-performing agents.
During the challenge phase an agent needs to stake some tokens and depending
on the results he can either earn more tokens or loose the initial deposit.
The exact logic for token redistribution is encoded as a parameter passed
to the challenge method.
"""
function simToken(num_of_steps, agents::Vector{Agent}, redistribution, benchmarks)
    registry = Float64[]
    history = Float64[]

    for round in 1:num_of_steps
        application(registry, history, agents, proRataTokenVote)
        challenge(registry, agents, 10, proRataTokenVote, redistribution)
    end

    [b(registry, agents) for b in benchmarks]
end
