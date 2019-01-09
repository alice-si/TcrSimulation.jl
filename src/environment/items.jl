"""
Generates a random value from a truncated normal distribution that represents
a new item. It's used to simulate incoming application to the registry.
"""
function getRegistryCandidate()
    rand(TruncatedNormal(50, 20, 0, 100))
end

"""
Calculates the mean quality of the items in the given registry
"""
function registryMean(registry)
    length(registry) == 0 ? 0 : mean(registry)
end
