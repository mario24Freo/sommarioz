#' Add a horizontal line to gt 2-dimensional table (grammar of tables) package
#' Used to add lines to 2-d or row x column experimental design
#'
#' @param my.gt.table  A gt table
#' @param colour.line A character with the colour to use to draw the line
#' @param which.side a character, choose from top, bottom,right,left
#' @param my.style What style to use. Default ='solid'
#' @param my.rows A numeric or function. Which rows in table to highlight Default = everything()
#' @param my.columns A numeric or function. Which columns to highlight Default =c(3,5)
#' @param my.weight A numeric. Default = 5. Width of the lines.
#' Which columns to highlight Default =c(3,5)
#' @return A gt table (2-way table with coloured lines)
#' @examples
#' data(Clarke2010)
#' library(gt);library(gtExtras)
#' single.entries <- Clarke2010$Entry [ Clarke2010$colour.entry %in% 'black']
#' duplicate.entries <- Clarke2010$Entry [ Clarke2010$colour.entry %in% 'blue']
#' standard.entries <- Clarke2010$Entry [ Clarke2010$colour.entry %in% 'red']
#' mydata <- with(Clarke2010,
#' tapply(Entry,list(as.numeric(Row),as.numeric(Column)),FUN=identity))
#' mydata.df <- as.data.frame(mydata)
#' my.gt.table <- gt.2waytable.soz(mydata.df,
#'               list(single.entries,duplicate.entries,standard.entries),
#'               my.decorate=c(NA,'underline',NA),
#'               my.colours=c('blue','black','red') ,
#'               my.title='Clarke 2010 p-rep design',
#'               my.subtitle='')
#' all.3 <- gt.add.lines.2waytable.soz(my.gt.table,colour.line='red',
#' which.side='right',my.weight=5,
#' my.style='solid',my.rows=everything(),my.columns=c(3,5) )
#' all.3 <- gt.add.lines.2waytable.soz(all.3,colour.line='blue',
#' which.side='bottom',my.weight=5,
#' my.style='solid',my.rows=2,my.columns=everything() )
#' \dontrun{
#' # Save the table as a PNG (needs the webshot2 package and Chrome)
#' gt::gtsave(all.3, tempfile(fileext = ".png"))
#' }
#' @export
gt.add.lines.2waytable.soz =function(my.gt.table,
                                     colour.line='red',
                                     which.side='right',
                                     my.weight=5,
                                     my.style='solid',
                                     my.rows=everything(),
                                     my.columns=c(3,5)
)
{
    new.gt.table<-
    my.gt.table %>%
  tab_style(
    style = cell_borders(
      sides = which.side,       # Options: "top", "bottom", "left", "right", "all"
      color = colour.line,      # Your preferred color (Hex code or named color)
      weight = px(my.weight),         # Thickness of the line
      style = "solid"         # Line style: "solid", "dashed", "dotted"
    ),
    locations = cells_body(
      columns = my.columns, #
      rows = my.rows               #
    )
  )
 return(new.gt.table)
}#end of function
