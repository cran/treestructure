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
library(ape)
library(treestructure)
library(phangorn)

## -----------------------------------------------------------------------------
pruned_tree <- readRDS( system.file('Ebola_down_sampled_tree.rds',
                                    package='treestructure') )


## ----eval=FALSE---------------------------------------------------------------
# trestruct_res <- trestruct(pruned_tree,
#                            minCladeSize = 30,
#                            nodeSupportValues = TRUE,
#                            nodeSupportThreshold = 95,
#                            level = 0.01)

## -----------------------------------------------------------------------------
trestruct_res <- readRDS( system.file('downsampled_tree_struc.rds',
                                      package='treestructure') )

plot(trestruct_res, use_ggtree = T) + ggtree::geom_tippoint()

## -----------------------------------------------------------------------------
#Note that this tree has more sequences than the previous tree used in this
#tutorial.
new_tree <- ape::read.nexus( system.file('Makona_1610_genomes_2016-06-23.ml.tree',
                                         package='treestructure') )

#now we can root the tree using mid-point rooting for illustration
ml_rooted_tree <- phangorn::midpoint(new_tree)

#now we need to remove the quotes from the tip names (to avoid an error with 
#treestructure function)
ml_rooted_tree$tip.label <- unlist(lapply(ml_rooted_tree$tip.label, 
                                          function (x) gsub("'", "", x)))


## -----------------------------------------------------------------------------
trestruct_add_tips <- addtips(trst = trestruct_res, tre = ml_rooted_tree)

plot(trestruct_add_tips, use_ggtree = T) + ggtree::geom_tippoint()

## -----------------------------------------------------------------------------

#compare sequences in cluster 1 from trestruct_res object and the 
#trestruct_add_tips object

tree1_cluster1 <- trestruct_res$clusterSets$`1`
tree2_cluster1 <- trestruct_add_tips$clusterSets$`1`

length(tree1_cluster1)
length(tree2_cluster1)


## -----------------------------------------------------------------------------

sum(tree1_cluster1 %in% tree2_cluster1)


