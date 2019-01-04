## Multi-agent simulation of Token Curated Registries
This project implements an environment for testing different variations of the
[TCR](https://hackernoon.com/token-curated-registry-tcr-design-patterns-4de6d18efa15) 
crypto-economic protocol. Users have the ability to parametrize the core TCR algorithm, define the population of agents
and see how the curation process works in action and under which conditions it's most effective.  

## TCR
Token Curated Registry is a mechanism [introduced by Mike Goldin](https://medium.com/@ilovebagels/token-curated-registries-1-0-61a232f8dac7) where a set of actors collectively create and maintain a list of items by voting on which entry should be admitted to the list. There is an intrinsic token that give the holders voting rights proportional to the amount of tokens they posses. The token works as an incentive system to offer the curators benefits for performing their job judiciously.

In the short term, token holders may get an instant reward for rejecting low quality candidates through the admission mechanism. In order to be considered as a potential list entry, an applicant must put a deposit expressed in the registry tokens. If the item is accepted by the majority of curators the deposit is returned to the applicant. However, if the item is rejected the deposit is divided among those who vote against it, making an instant reward for performing a diligent applicant verification. 

In the long term, a well curated list is expected to gain popularity and increase the number of  applicants willing to be listed. Higher demand for tokens which are necessary to cover the deposit cost will pressure on the price of tokens which are available to be traded on the open market. Therefore, token holders who actively performed the curation process will be rewarded in the increased valuation of their tokens. 

Due to the simplicity of the basic mechanism it's often classified as one of the [crypto-economic primitives](https://medium.com/unframework/mimicables-decentralized-interfaces-introduction-new-crypto-primitive-c8af14910e5d) that could be used as a building block in other blockchain protocols. There are few companies, among the others, that are already implementing the TCR protocols: [MetaX](https://www.metax.io) (advertaising), [District0x](https://district0x.io) (virtual marketplaces), [MedCredits](https://medcredits.io) (medical professionals registry), [Ocean Protocol](https://oceanprotocol.com) (data sets curation), [Messari](https://messari.io) (crypto-assets investments).

## Simulations

Although TCR gained a lot of attention and there are many startups trying to implement this approach the effectiveness of the core mechanism haven’t been properly tested. It is unknown which assumptions about the token holder incentives are crucial for the algorithm to work as expected. The TCR model contains many variables, and even the author of the original idea, confirms that *Parameterization of registries is not considered well-solved at this time.* Moreover, there are more and more variations of the TCR approach but there is no framework to compare them and indicate which direction of further development may be most promising. 

The final answer to the problems described above will be known only after such a system is fully implemented and deployed to the mass audience which may take several years of development and consume extensive investments. We want to propose a lightweight approach to test the TCR model which can bring approximate answers which is based on computer simulations and is cheaper and faster to execute. 

This project uses [Agent-based computational economics (ACE)](https://en.wikipedia.org/wiki/Agent-based_computational_economics) framework, which it’s a relatively new research paradigm aiming to study economic problems as a dynamic model of interacting autonomous agents. Such phenomena could be studied with the help of software components. Using the distributed systems and parallel processing to implement this sort of models often classified a Multi Agent Simulation approach.

## Architecture

The core building blocks of the simulation are **items** which could populate the registry, **agents**, who perform the curation according to the rules defining their behvaiour called **actions**.



The basic building blocks are combined in higher order objects called **simulations** which encode the algorithm for a certain TCR model. There is also a set of analytical functions, that could be attached to a simulation, in order to provide insgights called **benchmarks**.

Simulation modes that are defined in [simulations.jl](/src/simulations/simulations.jl) :

Function | Simulation mode
--- | --- 
*simSimple* | The basic algorithm where on every step of the iteration there is a new item applying to the registry that is being collectively judged by agents during the majority voting
*simChallenge* | Apart from voting on a new appliations, a random agent challenges the item that he consider the worst in the registry
*simToken* | This mode introduces a token as a mean to reward well-performing agents. During the challenge phase an agent needs to stake some tokens and depending on the results he can either earn more tokens or loose the initial deposit. The exact logic for token redistribution is encoded as a parameter passed to the challenge method. 

## Running simulations

There is a sample code showning how to implement a set of simulations: 

```
function compareEfficiency()
  for acc in 0:5:100
    noToken = [simChallenge(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean])[1] for i in 1:100]
    token = [simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean])[1] for i in 1:100]
    boost = mean(token) - mean(noToken)
    test = pvalue(UnequalVarianceTTest(token, noToken))
    significant = test < 0.05
    println("$acc, $boost, $test, $significant")
  end
end
```

It involves iteratively increasing the acc (agents accuracy) parameter and compare how does it affect the behaviour of two different simulation models: with and without a token. 

Every simulation is executed 100 times. Let's take a closer look how it's defined: 

```
simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean])
```

The function name (simToken) defines the model of TCR used (one involving token). The first parameter (1000) is the number of steps, during which agents evaluate the items, the second parameter contains the setup of the population of agents (100 agents chosen from a normal distribution with a defined accurany and factor 20 defining the diveristy) and the last parameter it's a set of statistics. 

The last part of the code defines the logic for computing custom statistics like the significance of the difference between two mens: 

```
test = pvalue(UnequalVarianceTTest(token, noToken))
significant = test < 0.05
```   

and the final line is just printing the result to the standard output in the desired format for further analysis or visualisation: 

```
println("$acc, $boost, $test, $significant")
```

As the framework is still under the development we wanted to mantain a right balance between encoding common features in predefined functions and allowing users to define their own logic in the most flexible way.


## Contribute
This project is still a work in progress, so if feel free to join and give us a hand building this tool.
Any forms of contibutions are more than welcome.
Please create an issue to suggest a change or submit a bug.
We'll also appreciate new scenarios or simulation modes implemented by you!

## License

This project is released under the [MIT License](LICENSE).
