using Plots, Distributions, KernelDensity
gr()

n = 1_000

dist = Normal()
x = rand(dist, n)
histogram(x)

distnames = ("Normal", "Exponential", "Poisson", "Gamma", "Beta")
distlist = (Normal(), Exponential(), Poisson(), Gamma(), Beta())

struct DistCompare
    x::Vector{Float64}
    xx::Vector{Float64}
    yy::Vector{Float64}
end

arr = Vector{DistCompare}()

for dist ∈ distlist
    x = rand(dist, n)
    dens = KernelDensity.kde(x)
    push!(arr, DistCompare(x, dens.x, dens.density))
end

subplot(511)
for i in 1:length(distnames)
    a = arr[i]
    distname = distnames[i]
    histogram(a.x, color=:orange, label="$distname PDF")
    plot!(a.xx, a.yy*n*1.0, color=:blue, linewidth=2, label="KDE")
end
