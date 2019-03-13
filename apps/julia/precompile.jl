using Pkg

function precompile(pkg::String)
    eval(Meta.parse("using $pkg"))
end

const PKGS = String.(keys(Pkg.installed()))

if "ProgressMeter" in PKGS
    using ProgressMeter
    useprogress = true
    progress = Progress(length(PKGS), 1, "Precompiling Packages")
else
    useprogress = false
end

for (i, pkg) in enumerate(PKGS)
    if useprogress
        next!(progress)
    else
        if i==1
            println("precompiling packages:")
        end
        status = "$pkg ($i/$(length(PKGS)))"
        println("\t$status")
    end
    precompile(pkg)
end
