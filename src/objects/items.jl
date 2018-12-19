function getRegistryCandidate()
    rand(TruncatedNormal(50, 20, 0, 100))
end

function registryMean(registry)
    length(registry) == 0 ? 0 : mean(registry)
end
