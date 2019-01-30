using Pkg

function get_previous_julia_version(current::VersionNumber=VERSION)::VersionNumber
    search_dir = "$(homedir())/.julia/environments"
    versions = sort(VersionNumber.(readdir(search_dir)))
    if versions[end] == current
        pop!(versions)
    end
    return versions[end]
end

function get_installed_packages(version::VersionNumber=VERSION)::Vector{String}
    pkgdir = "$(homedir())/.julia/environments/v$(version.major).$(version.minor)/"
    project_file = readlines("$pkgdir/Project.toml")
    pkgs = String[]
    pkg_list_active = false
    for (i, line) in enumerate(project_file)
        if line == "[deps]"
            pkg_list_active = true
            continue
        elseif pkg_list_active && line == ""
            break
        end
        if pkg_list_active
            pkgs = [pkgs; split(line, ' ')[1]]
        end
    end
    return pkgs
end

function transfer_pkgs()
    currently_installed = keys(Pkg.installed())
    previously_installed = get_installed_packages(get_previous_julia_version())
    for pkg in previously_installed
        print("\nLooking for package $pkg...")
        if pkg in currently_installed
            print("already installed.\n")
        else
            print("attempting installation.\n")
            try
                Pkg.add(pkg);
            catch
                continue
            end
        end
    end
    return nothing
end

transfer_pkgs()
