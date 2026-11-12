#' Two-dimensional table using gt (grammar of tables) package
#'
#' Creates a graph with minimal colour showing a plan for 2-d
#' or a row x column experimental design
#'
#' @param mydata.df A data frame of a two-way table typical of entries or treatment labels
#' @param entry.groups A list with a number of subsets of the entries or treatment labels
#' @param my.decorate Can be NULL or a set of values to correspond to each list of entries
#' which are the values for the decorate argument in gt()
#' these are "underline", "overline", "line-through" or "none" or NA
#' So we could have c(NA,"underline" NA)to underline the second entry group in the list above
#' @param my.colours A list of colours for each entry corresponding to the entry subsets
#' @param my.title A character with a title (default="title")
#' @param my.subtitle A character with a subtitle (default ="subtitle")
#' @param missing.cell A character. Default ="". You can choose "-". 
#' @return mytable. A 2-way table of class gt_tbl().
#' @examples
#' library(gt);library(gtExtras)
#' data(JAC12463.eg3)
#' single.entries <- JAC12463.eg3$Entry [ JAC12463.eg3$colour.entry %in% 'blue']
#' duplicate.entries <- JAC12463.eg3$Entry [ JAC12463.eg3$colour.entry %in% 'black']
#' standard.entries <- JAC12463.eg3$Entry [ JAC12463.eg3$colour.entry %in% 'red']
#' mydata <- with(JAC12463.eg3,
#' tapply(Entry,list(as.numeric(Row),as.numeric(Column)),FUN=identity))
#' mydata.df <- as.data.frame(mydata)
#' ans.table <- gt.2waytable.soz(mydata.df,
#'               list(duplicate.entries,standard.entries),
#'               my.decorate=c('underline',NA),
#'               my.colours=c('black','red') ,
#'               my.title='JAC12463-example 3 p-rep design',
#'               my.subtitle='Exclude single entries')
#'
#' \dontrun{
#' # Save the table as a PNG (needs the webshot2 package and Chrome)
#' gt::gtsave(ans.table, tempfile(fileext = ".png"))
#' }
#' @export
gt.2waytable.soz =function(mydata.df,entry.groups=list(3),
                            my.decorate=NULL,
                             my.colours=c('blue','black','red') ,
                             my.title='my title',
                             my.subtitle="subtitle",
                             missing.cell ="")
{ #start of function


mytable=gt::gt(mydata.df,rownames_to_stub = TRUE)
mytable = gt::sub_missing(mytable,missing_text = "")
mytable=gt::tab_header(mytable,
                       title = my.title,
                       subtitle = my.subtitle)

mytable=gt::tab_style(mytable,
                      style = cell_borders(
                        sides = c("top", "bottom","left","right"),
                        color = "black",
                        weight = px(1.5),
                        style = "solid"
                      ),
                      locations = cells_body()
)

col.names.vect <- colnames(mydata.df)

nGroup=length(entry.groups)

for (iG in 1:nGroup){

  iG.entry.names=entry.groups[[iG]]
  len1=length(my.colours)
  if(len1==0) my.colour1='black'
  if(len1==1) my.colour1=my.colours[1]
  if(len1>1)my.colour1=my.colours[iG]

    mydecorate1=NULL
    if( is.null(my.decorate)) my.decorate1=NULL
    if(!is.null(my.decorate)) {
      if(!is.na(my.decorate[iG])) my.decorate1=my.decorate[iG]
      if(is.na(my.decorate[iG]))  my.decorate1=NULL}

for(i in seq_along(col.names.vect)) {

  mytable <- gt::tab_style(mytable,
                           style = gt::cell_text(color=my.colour1,weight='bold',
                                                 #
                                                 decorate = my.decorate1,
                                                 #decorate='underline',
                                                 size="large"),
                           locations = gt::cells_body(
                             columns = col.names.vect[i],
                             rows = mytable$`_data`[[col.names.vect[i]]] %in%
                               iG.entry.names )

  )

}#end of i loop



}#end of iG loop

mytable=
           gt::cols_align(mytable,
  align = c("right"),
  columns = everything()
)
return(mytable)
}#end of function

