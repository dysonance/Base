using Distributions, Plots

function visualize_gamma()
    a = 0.01:0.01:4
    b = 0.01:0.01:4
    A = repeat(a', length(b), 1)
    B = repeat(b, 1, length(a))
    Z = Gamma.(A, B)

    xx = range(0.01, 4, length=100)
    p = contour(a, b, pdf.(Z,0.01), title="Gamma PDF for x=0.01")

    anim = @animate for x in xx
        contour(a, b, pdf.(Z,x), title="Gamma PDF for x=$(round(x,digits=4))")
    end
    gif(anim, "tmp.gif", fps=10)
    try
        if "BROWSER" in keys(ENV)
            browser = ENV["BROWSER"]
            cmd = `open tmp.gif -a $browser`
            run(cmd)
        else
            browser = "$(ENV["HOME"])/Applications/Google Chrome.app/"
            cmd = `open tmp.gif -a $browser`
            run(cmd)
        end
    finally
        return anim
    end
end
visualize_gamma()
