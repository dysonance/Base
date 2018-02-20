using Temporal, Base.Dates, Missings, DataArrays, BenchmarkTools

println("Downloading data")
X = quandl("CHRIS/CME_CL1")

println("Converting data")
A = copy(Array{Float64}(X.values))
D = copy(DataArray(Array{Float64}(A)))
M = copy(Array{Union{Float64,Missing}}(A))

println("Replacing NaN's")
for j = 1:size(A,2)
    println("\t$j")
    nan_idx = isnan.(A[:,j])
    D[nan_idx,j] = NA
    M[nan_idx,j] = missing
    A[nan_idx,j] = NaN
end

# analyze performance of different missing values conventions
f1(x) = mean(x[!isnan.(x)])
f2(x) = mean(x[!isna.(x)])
f3(x) = mean(x[!ismissing.(x)])

nan_time = @benchmark f1(A)
na_time = @benchmark f2(D)
missing_time = @benchmark f3(M)

p = 0:0.01:1
timings = [quantile(nan_time.times, p) quantile(na_time.times, p) quantile(missing_time.times, p)]

