using Random, Statistics, Distributions, GLM, ProgressMeter

const SIMULATIONS = 10_000

const N = 10:5:100
const T = 120:120:1200
const K = 1

pvalues = zeros((SIMULATIONS, length(N), length(T))) .* NaN
tstats = zeros((SIMULATIONS, length(N), length(T))) .* NaN

progress = Progress(SIMULATIONS*length(N)*length(T), desc="Running Simulations")
@inbounds for i in 1:SIMULATIONS
    @inbounds for (n,N) in enumerate(N), (t,T) in enumerate(T)
        next!(progress)
        Rt = rand(Normal(0, 1/252), (T,N))
        ft = rand(Normal(), (T,K))

        beta = (Rt'Rt)^-1 * Rt'ft
        mu = ft - Rt*beta

        gamma = zeros(T,2)*NaN
        X = [ones(N) beta]
        for t in 1:T
            gamma[t,:] = (X'X)^-1 * X'Rt[t,:]
        end

        tstat = mean(gamma[:,2]) / (std(gamma[:,2])/sqrt(T))
        pvalue = cdf(TDist(T-1), tstat)
        pvalues[i,n,t] = pvalue
        tstats[i,n,t] = tstat
    end
end
