module Items
    using Distributions

    function getCandidate()
        rand(Normal(50,10))
    end

end
