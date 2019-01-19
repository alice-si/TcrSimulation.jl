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

## Results

### Compare efficiency of simulation modes

Let's first comapre the efficiency of different simulation modes: simple voting on applicatnts, possibility of challenging existing applicants, necessity to stake tokens for a challenge. All of the modes will be tested at different scenarios where we will manipulate the accuracy of agents. In every scenario all of the agents will have the same fixed accuracy. The scenario will be run over 1000 steps and it will be repeated 20 times to reduce the randomness. This setup could be implemented in a few lines of code:

```
for acc in 0:5:100
        applicationOnly = mean([simSimple(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:20])[1]
        challenge = mean([simChallenge(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:20])[1]
        token = mean([simToken(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:20])[1]
        println("$acc, $applicationOnly, $challenge, $token")
    end
```
Let's take a look at the results:

![tcr_chart_simulation_modes](https://s3.eu-west-2.amazonaws.com/alice-res/tcr/tcr_chart_simulation_modes.png)

We may observe that in all of the modes higher accuracy of curators brings better registry quality. Adding ability to challenge existing elements improves the registry quality. There is also an improvement caused by introducing the need of staking tokens although this effect is weaker when the accuracy of curators is high.  


### Effects of agents diversification

In the previous experiment we created an environment when all of the curators have got an equal accuracy of judgement. Let's explore the scenario where agents may differ in the quality of their assesment. We will also manipulate the accuracy while iterating the scenarios but this time it will only mean an average accuracy which will be dispersed following the normal distribution with the standard deviation of 20. We're going to compare the effects of diversifying agents and the effect of requiring agents to stake tokens. This experiment could be implemented as follows:

```
    for acc in 0:5:100
        noTokenFixed = mean([simChallenge(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:30])[1]
        noTokenDiv = mean([simChallenge(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:30])[1]
        tokenFixed = mean([simToken(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean]) for i in 1:30])[1]
        tokenDiv = mean([simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean]) for i in 1:30])[1]

        divEffect = mean([tokenDiv - tokenFixed, noTokenDiv - noTokenFixed])
        tokenEffect = mean([tokenDiv - noTokenDiv, tokenFixed - noTokenFixed])
        tokenDivEffect = tokenDiv - noTokenFixed
        println("$acc, $divEffect, $tokenEffect, $tokenDivEffect")
    end
```

Let's analyse the results:

![chart_tokens_diversifications](https://s3.eu-west-2.amazonaws.com/alice-res/tcr/tcr_chart_tokens_diversification.png)

We may see that differsification helps to improve the quality of registry for modes with and without token staking. 

For better visibility let's also look at difference between registry quality at the scenario with the biggest contrast.

![tcr_chart_cumulative](https://s3.eu-west-2.amazonaws.com/alice-res/tcr/tcr_chart_cumulative.png)



### Gain from tokens at different accuracy

On the previous chart we've noticed that the increase in the registry accuracy caused by token staking differs according to the average accuracy of the agents. Let's try to examine that more closely. We will create two groups of agents, one using tokens and one without them. The only condition that will be manipulated is the average accuracy. We will analyse the resulting registry qaulity at the end of 1000 steps of simulation. We're going to additionaly test the statistical significance of the difference to be check if the gain of tokens is not due to random factors:


```
for acc in 0:5:100
    noToken = [simChallenge(1000, setupAgentsWithFixedAccuracy(100, acc), [benchmarkRegistryMean])[1] for i in 1:30]
    token = [simToken(1000, setupRandomAgents(100, acc, 20), [benchmarkRegistryMean])[1] for i in 1:30]
    boost = mean(token) - mean(noToken)
    test = pvalue(UnequalVarianceTTest(token, noToken))
    significant = test < 0.05
    println("$acc, $boost, $test, $significant")
end
```
Let's look at the results:

![tcr_chart_efficiency_bonus](https://s3.eu-west-2.amazonaws.com/alice-res/tcr/tcr_chart_efficiency_bonus.png)

We may observe that the highest gain from the usage of tokens is when there is a population of agents with the medium level of accuracy. As the accuracy grows further and the groups of curators constists only of experts there is no additional gain of tokens.  


### Optimum environment for tokens

We've analysed how the accuracy of agents affects the benefits of introducing tokens. Let's now check the infulence of other factors such as the number of agents and the number of simulation steps:


```
for noAgents in 10:10:200
    for noSteps in 100:100:2000
        noToken = [simChallenge(noSteps, setupRandomAgents(noAgents, 50, 20), [benchmarkRegistryMean])[1] for i in 1:10]
        token = [simToken(noSteps, setupRandomAgents(noAgents, 50, 20), [benchmarkRegistryMean])[1] for i in 1:10]
        boost = mean(token) - mean(noToken)
        println("$noSteps, $noAgents, $boost")
    end
end
```
On the following chart we present only the configuration that displayed a significant improvement of registry quality ( largen thatn 10 points): 

![tcr_chart_optimum_space](https://s3.eu-west-2.amazonaws.com/alice-res/tcr/tcr_chart_optimum_space.png)

We may observe that there is a relation between the number of agents and the number of steps that is required to produce a positive effect of tokens staking. The staking process need time to fully unlock it's potential and the larger group of agents needs the greater number of steps. After a certain point there is no further improvement cause by extending the simulation length. 


### Inner circle of experts

Up to this point we've analysed only a homogenous population of agents. Although their accuracy may differ between individual curators it stays at roughly the same level for the whole group. Let's analyse a scenario when we mix a group of low accuracy level agents (amateurs) and slowly introduce to this group high accuracy individuals (experts). We're are going to check how this proces looks in a population with and without tokens: 

```
function expertsInnerCirleSize()
    for expertCount in 1:1:100
        controlLow= mean([simChallenge(1000, setupAgentsWithFixedAccuracy(100, 20), [benchmarkRegistryMean])[1] for i in 1:20])
        expertTokens = mean([simToken(1000, setupMixedAgents(100-expertCount, 20, expertCount, 100), [benchmarkRegistryMean])[1] for i in 1:20])
        expertNoTokens = mean([simChallenge(1000, setupMixedAgents(100-expertCount, 20, expertCount, 100), [benchmarkRegistryMean])[1] for i in 1:20])
        controlHigh = mean([simChallenge(1000, setupAgentsWithFixedAccuracy(100, 100), [benchmarkRegistryMean])[1] for i in 1:20])
        println("$expertCount, $controlLow, $expertTokens, $expertNoTokens, $controlHigh")
    end
end
```
At the chart we present the scenario for a population wiht tokens, without them and two control groups consisted only with low accuracy agents and only with experts: 

![tcr_chart_experts_count](https://s3.eu-west-2.amazonaws.com/alice-res/tcr/tcr_chart_experts_count.png)

We see that the more experts enter the population the higher registry quality is achieved. We may observe that the introduction of tokens reduce the ratio of expert that is necessary to produce high quality results from about 40% to 12%. 

## Contribute
This project is still a work in progress, so if feel free to join and give us a hand building this tool.
Any forms of contibutions are more than welcome.
Please create an issue to suggest a change or submit a bug.
We'll also appreciate new scenarios or simulation modes implemented by you!

## License

This project is released under the [MIT License](LICENSE).
