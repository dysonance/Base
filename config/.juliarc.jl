# julia custom startup file
# to be placed at: ~/.julia/config/startup.jl

const CUSTOM_PROMPT = ":> "

using REPL
function customize_repl(repl)
    repl.interface = REPL.setup_interface(repl)
    repl.interface.modes[1].prompt = CUSTOM_PROMPT
    return
end
atreplinit(customize_repl)
