using Pkg

const PKGS = String.(keys(Pkg.installed()))

function precompile_one(pkg::String)
    eval(Meta.parse("using $pkg"))
end

function precompile_all(useprogress::Bool=true)
    if useprogress
        progress = Progress(length(PKGS), 1, "Precompiling Packages")
    end
    @inbounds for (i, pkg) in enumerate(PKGS)
        if useprogress
            next!(progress)
        else
            if i == 1
                println("precompiling packages:")
            end
            status = "$pkg ($i/$(length(PKGS)))"
            println("\t$status")
        end
        precompile_one(pkg)
    end
end

# first update everything
Pkg.update()

# determine if a progress bar is possible
useprogress = false
if "ProgressMeter" in PKGS
    using ProgressMeter
    useprogress = true
end

# precompile all packages iteratively
precompile_all(useprogress)
