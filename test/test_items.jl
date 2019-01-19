facts("Testing item creation") do
    srand(1234)
    @fact TcrCore.getRegistryCandidate() --> 67.34694403902492
    @fact TcrCore.getRegistryCandidate() --> 31.96512368286366
    @fact TcrCore.getRegistryCandidate() --> 40.110424929915325
end
