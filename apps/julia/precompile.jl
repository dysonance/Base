using Pkg

pkgs = String.(keys(Pkg.installed()))

println("precompiling packages:")
for (i, pkg) in enumerate(pkgs)
    println("\t$pkg ($i/$(length(pkgs)))")
    eval(Meta.parse("using $pkg"))
end
