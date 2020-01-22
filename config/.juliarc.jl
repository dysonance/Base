#=
julia custom startup file
to be placed at: ~/.julia/config/startup.jl

NOTE: this file is for julia versions v0.7 onward
=#

using REPL
function setup_repl(repl)
    repl.interface = REPL.setup_interface(repl)
    # default input prompt
    repl.interface.modes[1].prompt = ":> "
    # shell/terminal prompt
    repl.interface.modes[2].prompt = "\$> "
    # help prompt
    repl.interface.modes[3].prompt = "?> "
    #  # package manager prompt
    #  repl.interface.modes[6].prompt = "[> "
    return
end
atreplinit(setup_repl)
const global JULIA_HOME = expanduser("~/Applications/Julia/master/usr/bin")
