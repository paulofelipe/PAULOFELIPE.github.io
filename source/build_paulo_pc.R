setwd("~/Documentos/paulofelipe.github.io/source")



servr::jekyll(dir = ".", input = c(".", "_source", "_posts"), 
              output = c(".", "_posts", "_posts"), 
              script = c("Makefile", "build.R"), 
              serve = FALSE, 
              command = "rake generate")

# Se não funcionar
# rbenv exec bundle install --path vendor/bundle

# library(stringr)
# arquivos <- list.files('_posts/')
# arquivos <- str_replace_all(arquivos, "[0-9]{4}-[0-9]{2}-[0-9]{2}-", "")
# arquivos <- str_replace_all(arquivos, "\\.md", "")
# arquivos <- str_replace_all(arquivos, "\\.markdown", "")
# 
# for(i in arquivos){
#   file.copy("_includes/htmlwidgets/index.html", to = paste0("_includes/htmlwidgets/", i, ""))
# }
