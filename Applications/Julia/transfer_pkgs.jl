function ispkg(pkg::S)::Bool where S<:AbstractString
    isalpha(pkg[1]) && isupper(pkg[1])
end

get_previous_julia_version()::VersionNumber = VersionNumber("0.$(Int(VERSION.minor)-1)")

function get_installed_packages(version::VersionNumber=VERSION)::Vector{String}
    pkgdir = "$(Pkg.dir())/../v0.$(version.minor)/"
    pkgs = readdir(pkgdir)
    keep_pkgs = [ispkg(pkg) for pkg in pkgs]
    return pkgs[keep_pkgs]
end

function transfer_pkgs()::Void
    pkgs = get_installed_packages(get_previous_julia_version())
    @inbounds for pkg in pkgs
        print("\nLooking for package $pkg...")
        if pkg in get_installed_packages()
            print("already installed.\n")
        else
            print("attempting installation.\n")
            try
                Pkg.add(pkg);
            end
        end
    end
    return nothing
end

transfer_pkgs()
