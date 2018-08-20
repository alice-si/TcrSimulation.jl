module Items
    using Distributions

    function getCandidate()
        rand(Normal(50,20))
    end

end
