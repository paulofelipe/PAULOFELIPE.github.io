setwd("~/Documentos/paulofelipe.github.io/source")

servr::jekyll(dir = ".", input = c(".", "_source", "_posts"), 
              output = c(".", "_posts", "_posts"), 
              script = c("Makefile", "build.R"), 
              serve = FALSE, 
              command = "rake generate")

# Se não funcionar
# rbenv exec bundle install --path vendor/bundle

