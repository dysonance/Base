if VERSION>=v"0.7.0-"
    using Pkg
end

pkgs = [String(pkg) for pkg in keys(Pkg.installed())]
@inbounds @parallel for pkg in pkgs
    try
        cmd = `$(ENV["_"]) --compile=all --optimize=3 -e "using $(pkg)"`
        run(cmd)
    catch
        println("Unable to initialize package $pkg")
    end
end
