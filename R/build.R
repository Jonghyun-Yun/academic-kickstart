## borrowed from https://yutani.rbind.io/post/2017-10-25-blogdown-custom/
## catch "local" arg passed from blogdown::build_site()
local <- commandArgs(TRUE)[1] == "TRUE"

## set common options for knitr
knitr::opts_knit$set(
  base.dir = normalizePath("static/", mustWork = TRUE),
  base.url = "/"
)

knitr::opts_chunk$set(
  cache.path = normalizePath("cache/", mustWork = TRUE),
  collapse = TRUE,
  comment  = "#>"
)

## list up rmakrdown files
Rmd_files <- list.files("content", "\\.rmarkdown$", recursive = TRUE, full.names = TRUE)

## list up md files
md_files  <- sub("\\.rmarkdown$", ".markdown", Rmd_files)
names(md_files) <- Rmd_files

## knit it when:
##   1) the correspondent md file does not exist yet
##   2) the Rmd file was updated after the last time md file had been generated 
needs_knitted <- !file.exists(md_files) | utils::file_test("-ot", md_files, Rmd_files)

message("skip: \n    ", paste(Rmd_files[!needs_knitted], collapse = "\n    "))

for (rmd in Rmd_files[needs_knitted]) {
  base_name <- tools::file_path_sans_ext(basename(rmd))
  path_base_name <- tools::file_path_sans_ext(rmd)
  path_base_name = gsub( "content/", "", path_base_name )
  knitr::opts_chunk$set(
   fig.path = glue::glue("{path_base_name}_files/figure-html/")
  )
  
  #set.seed(1984)
  knitr::knit(input = rmd, output = md_files[rmd], encoding = "UTF-8")
}

blogdown::hugo_build(local = local)
