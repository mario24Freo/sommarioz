#' The Italian word for summary is sommario.
#' So here is the same function as summary.
#' @param x Any object that has a summary function attached to that object.
#' @return s A summary of the object x.
#' @export
sommarioz <- function(x){s <- summary(x)
return(s)}
