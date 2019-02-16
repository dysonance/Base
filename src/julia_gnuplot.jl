using Temporal

function gplot(X::TS, style::String="lines")
    tmpdir = tempdir()
    scriptfile = "$tmpdir/tmp.gnu"
    datafile = "$tmpdir/tmp.csv"
    # format the script of plotting commands
    script = """
    set key autotitle columnheader
    set grid
    set datafile separator ","
    set xdata time
    set timefmt "%Y-%m-%d"
    set format x "%Y-%m-%d"
    plot for [i=2:$(size(X,2))] "$datafile" using 1:i with $style
    """
    # write the data and script to tmp directories
    tswrite(X, datafile)
    open(scriptfile, "w") do f
        write(f, script)
    end
    # create the shell command and run
    command = `gnuplot -c $scriptfile -p`
    result = run(command)
    return result
end

