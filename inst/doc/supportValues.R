## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 11,
  warning = FALSE,
  message = FALSE
)

## ----message=FALSE------------------------------------------------------------
library(treeio)
library(ggtree)
library(treestructure)

## ----eval=FALSE---------------------------------------------------------------
# #get the dated tree by first downloading it from the URL below
# tree_url <- "https://raw.githubusercontent.com/ebov/space-time/master/Data/Makona_1610_cds_ig.GLM.MCC.tree"
# tmp_file <- tempfile(fileext = ".tree")
# 
# #Download BEAST tree to a tmp file
# download.file(tree_url, tmp_file, mode = "wb")
# 
# #read the downloaded tree
# beast_tree <- read.beast(tmp_file)

## ----eval=FALSE---------------------------------------------------------------
# dated_tre <- as.phylo(beast_tree)

## ----eval=FALSE---------------------------------------------------------------
# # Get number of tips
# n_tips <- length(dated_tre$tip.label)
# 
# # Get BEAST tree as tibble (it will include node numbers and posterior probabilities)
# tree_data <- as_tibble(beast_tree)
# 
# #get posterior probability
# posterior <- as.numeric(tree_data$posterior[(n_tips + 1):nrow(tree_data)])
# 
# #add the posterior probability information to the `phylo` object
# dated_tre$node.label <- posterior

## ----eval=FALSE---------------------------------------------------------------
# trestruct_res_nobt <- trestruct(dated_tre,
#                                 fdr = 0.2,
#                                 minCladeSize = 10,
#                                 nodeSupportValues = FALSE)

## -----------------------------------------------------------------------------
trestruct_res_nobt <- readRDS( system.file('trestruct_res_nobt.rds',
                                           package='treestructure') )

plot(trestruct_res_nobt, use_ggtree = T) + ggtree::geom_tippoint()

## -----------------------------------------------------------------------------
country <- sapply(strsplit(trestruct_res_nobt$tree$tip.label, "\\|"), `[`, 4)
country[!country %in% c("SLE", "LBR", "GIN")] <- "other"
table(cluster = trestruct_res_nobt$clustering, country = country)

## ----eval = FALSE-------------------------------------------------------------
# trestruct_res_mcs20 <- trestruct(dated_tre, fdr = 0.2, minCladeSize = 20,
#                                  nodeSupportValues = FALSE)

## -----------------------------------------------------------------------------
trestruct_res_mcs20 <- readRDS( system.file('trestruct_res_nobt_mcs20.rds',
                                            package='treestructure') )

plot(trestruct_res_mcs20, use_ggtree = T) + ggtree::geom_tippoint()

## ----eval=FALSE---------------------------------------------------------------
# trestruct_res <- trestruct(dated_tre,
#                            fdr = 0.2,
#                            minCladeSize = 10,
#                            nodeSupportValues = TRUE,
#                            nodeSupportThreshold = 95)

## -----------------------------------------------------------------------------
trestruct_res <- readRDS( system.file('trestruct_res.rds',
                                      package='treestructure') )

plot(trestruct_res, use_ggtree = T) + ggtree::geom_tippoint()

## ----eval = FALSE-------------------------------------------------------------
# trestruct_chindex <- trestruct(dated_tre,
#                                minCladeSize = 10,
#                                nodeSupportValues = FALSE,
#                                level = NULL,
#                                levellb = 0.0001,
#                                levelub = 0.01)

## -----------------------------------------------------------------------------
trestruct_chindex <- readRDS( system.file('trestruct_chindex.rds',
                                      package='treestructure') )

plot(trestruct_chindex, use_ggtree = T) + ggtree::geom_tippoint()

