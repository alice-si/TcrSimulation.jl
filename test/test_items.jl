facts("Testing item creation") do
    srand(1234)
    @fact TcrCore.getRegistryCandidate() --> 75.15306885658612
    @fact TcrCore.getRegistryCandidate() --> 23.849429340152305
    @fact TcrCore.getRegistryCandidate() --> 35.66011614837721
end
