#install.packages('devtools')
#install.packages('remotes')
#remotes::install_github("rstudio/blogdown")
library(blogdown)
install_hugo()
# remember hugo version
#v.0.83.1
new_site(theme = "wowchemy/starter-academic")

serve_site()


