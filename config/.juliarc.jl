# julia custom startup file
# to be placed at: ~/.julia/config/startup.jl

const CUSTOM_PROMPT = ":> "

if VERSION >= v"0.7-"
    using REPL
    function customize_repl(repl)
        repl.interface = REPL.setup_interface(repl)
        repl.interface.modes[1].prompt = CUSTOM_PROMPT
        return
    end
    atreplinit(customize_repl)
elseif VERSION >= v"0.6-"
    function customize_repl(repl)
        repl.interface = Base.REPL.setup_interface(repl)
        repl.interface.modes[1].prompt = CUSTOM_PROMPT
        return
    end
    atreplinit(customize_repl)
end
