#' JAC12463.eg3 p-rep design
#'
#' @format A data frame with 24 rows and 5 variables:
#' \describe{
#'   \item{Entry}{Entry code (factor)}
#'   \item{Row}{Row number (factor)}
#'   \item{Column}{Column number (factor)}
#'   \item{colour.entry}{colour to use for text in cell}
#' }
#'
#' @source \insertRef{piepho2021generating}{sommarioz}
#' The article is open access and distributed under the Creative Commons
#'   Attribution 4.0 International licence (CC BY 4.0,
#'   \url{https://creativecommons.org/licenses/by/4.0/}). The data are
#'   reproduced here under the terms of that licence.
#'   Changes made: The matrix is converted into a data
#'   frame with the variables defined above.
#' @examples
#' # check A-efficiency of the design as per paper, should be 0.411
#' library(dae)
#' str(JAC12463.eg3)
#' unit.trt.canon <- dae::designAnatomy(formulae =
#'   list(unit=~ Row+Column+Row:Column, trt=~ Entry),
#'   data = JAC12463.eg3)
#' summ1<- summary(unit.trt.canon, which.criteria = c("aeff","eeff","order"))
#' summ2 <- summary(unit.trt.canon, which.criteria = c("aeff","eeff","order"), labels.swap = TRUE)
#' print(summ1)
#' print(summ2)
"JAC12463.eg3"
