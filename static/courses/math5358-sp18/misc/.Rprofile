## Customise the R prompt that prefixes every command
## (use " " for a blank prompt)
# options(prompt = paste("R> "))
options(prompt = paste("\033[0;36mR\033[0m> "))

## Don't convert text strings to factors with base read functions
## WARNING!!! This makes your code less portable/reproducible.
options(stringsAsFactors = FALSE)

# commands entered at the console don't pop-up tclk dialogs
options(menu.graphics=FALSE)

# A penalty to be applied when deciding to print numeric values in fixed or exponential notation.
# Positive values bias towards fixed and negative towards scientific notation.
# options(scipen=10)

## Don't show those silly significanct stars
options(show.signif.stars=FALSE)

# enable autocompletions for package names in
# `require()`, `library()`
utils::rc.settings(ipck = TRUE)

# warn on partial matches
#options(warnPartialMatchAttr = TRUE,
#        warnPartialMatchDollar = TRUE,
#        warnPartialMatchArgs = TRUE)

# fancy quotes are annoying and lead to
# 'copy + paste' bugs / frustrations
options(useFancyQuotes = FALSE)

# Don’t Let R Blow Up your Console
# Did you really want to see all 10000 elements of that list? Probably not, right? Use:
options(max.print = 999)

## `local` creates a new, empty environment
## This avoids polluting .GlobalEnv with the object r
## local({r <- getOption("repos");
##       r["CRAN"] <- "https://cran.revolutionanalytics.com";   ##	Revolution Analytics, Dallas
##       options(repos=r)})

.__Rprofile.env__. <- new.env(parent = emptyenv())

### Use '.Rprofile' to quickly open your ~/.Rprofile

# Create an empty string with class '__Rprofile__'
# and assign it to our .__Rprofile.env__.
#
# Here, `class<-`() is just a sneaky way of creating
# an object with some class all in one expression.
assign(".Rprofile",
       `class<-`('', "__Rprofile__"),
       envir = .__Rprofile.env__.)

# Assign a print for the "__Rprofile__" class in that
# same environment. By printing the `.Rprofile` object,
# we actually go and edit it!
assign("print.__Rprofile__",
       function(x) file.edit("~/.Rprofile"),
       envir = .__Rprofile.env__.)

## Read data on clipboard
.__Rprofile.env__.$read.cb <- function(...) {
  ismac <- Sys.info()[1]=="Darwin"
  if (!ismac) read.table(file="clipboard", ...)
  else read.table(pipe("pbpaste"), ...)
}

## List objects and classes (from @_inundata, mod by ateucher)
.__Rprofile.env__.$lsa <- function() {
    obj_type <- function(x) class(get(x, envir = .GlobalEnv)) # define environment
    foo = data.frame(sapply(ls(envir = .GlobalEnv), obj_type))
    foo$object_name = rownames(foo)
    names(foo)[1] = "class"
    names(foo)[2] = "object"
    return(foo)
}

## Open Finder to the current directory on mac
.__Rprofile.env__.$macopen <- function(...) if(Sys.info()[1]=="Darwin") system("open .")

## Attach all the variables above
attach(.__Rprofile.env__.)

# Print the wokring directory
pwd <- ""
class(pwd) <- "__pwd__"
print.__pwd__ <- function(x, ...) print(getwd())

# Close R session without saving the R workspace
q <- function (save="no", ...) {
  quit(save=save, ...)
}

#Print Library Paths on Startup
if (length(.libPaths()) > 1) {
  msg <- "Using libraries at paths:\n"
} else {
  msg <- "Using library at path:\n"
}
libs <- paste("-", .libPaths(), collapse = "\n")
message(msg, libs, sep = "")


#if(Sys.getenv("TERM") == "xterm-256color")
#  library("colorout")

sshhh <- function(a.package){
  suppressWarnings(suppressPackageStartupMessages(
    library(a.package, character.only=TRUE)))
}

## Load packages
auto.loads <-c("data.table", "ggplot2")
if(interactive()){
  invisible(sapply(auto.loads, sshhh))
}

## .First() run at the start of every R session.
.First <- function(){
  if(interactive()){
    library(utils)
    timestamp(,prefix=paste("##------ [",getwd(),"] ",sep=""))
  }
}

## .Last() run at the end of the session
.Last <- function(){
  if(interactive()){
    hist_file <- Sys.getenv("R_HISTFILE")
    if(hist_file=="") hist_file <- "~/.Rhistory"
    try(savehistory(hist_file))
  }
}
