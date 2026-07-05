## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 6,
  warning = FALSE,
  message = FALSE
)

## -----------------------------------------------------------------------------
library(ape)
library(treestructure)

tree <- read.tree(system.file("sim.nwk", package = "treestructure"))
s <- trestruct(tree, fdr = 0.05)
print(s)

## -----------------------------------------------------------------------------
s$global.test

## -----------------------------------------------------------------------------
readRDS(system.file("vignette_fwer.rds", package = "treestructure"))

## -----------------------------------------------------------------------------
readRDS(system.file("vignette_hetero.rds", package = "treestructure"))

## ----eval = FALSE-------------------------------------------------------------
# trestruct(tree, fdr = 0.05, split = "bh")

## ----eval = FALSE-------------------------------------------------------------
# # tree$node.label holds support values in [0, 100] (or [0, 1])
# trestruct(tree, fdr = 0.05,
#           nodeSupportValues = TRUE, nodeSupportThreshold = 95)

