function getRegistryCandidate(rng)
    rand(rng, Normal(50,20))
end

function registryMean(registry)
    length(registry) == 0 ? 0 : mean(registry)
end
