
module Redistribute
    function none(votingResult, challenger, deposit)

    end

    function onlyChallengerReward(successful, challenger, deposit)
        challenger.balance += successful ? 2 * deposit : 0
    end

end
