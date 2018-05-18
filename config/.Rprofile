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
}
