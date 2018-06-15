.First = function(){
  options(repos=structure(c(CRAN="http://archive.linux.duke.edu/cran/")))
  options(width=140)
  options(scipen=1e3)
  options(shiny.port=8080)
  options(shiny.launch.browser=FALSE)
  options(datatable.print.topn=10)
  makeActiveBinding("ans", function() .Last.value, env=globalenv())
  library(colorout)
  setOutputColors256(normal=15,
                     number=9,
                     negnum=1,
                     zero=5,
                     date=2,
                     const=13,
                     infinite=13,
                     string=10,
                     true=6,
                     false=3,
                     warn=c(1,0,208),
                     error=c(1,1,11),
                     zero.limit=1e-8,
                     verbose=FALSE)

  # custom utility functions

  diffmat = function(x){
    D = matrix(as.numeric(NA), NROW(x), NROW(x))
    for (i in 1:NROW(x)){
      d = x[[i]] - x[-i]
      D[i,-i] = d
    }
    if (!all(is.na(diag(D)))){
      stop("Not all diagonal elements zero")
    }
    diag(D) = 0
    if (!is.null(names(x))) colnames(D) = rownames(D) = names(x)
    return(D)
  }

}

.Last = function(){
  if (interactive()){
    history_file = if (Sys.getenv("RHISTFILE") == "") "~/.Rhistory" else Sys.getenv("R_HISTFILE")
    try(savehistory(history_file))
  }
}
