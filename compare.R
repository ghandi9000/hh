### compare.R --- 
## Filename: compare.R
## Description: Compare fits
## Author: Noah Peart
## Created: Mon Mar 30 18:04:51 2015 (-0400)
## Last-Updated: Wed Apr  1 19:22:46 2015 (-0400)
##           By: Noah Peart
######################################################################
source("~/work/ecodatascripts/vars/heights/prep.R")                 # data prep
source("~/work/ecodatascripts/vars/heights/canopy/load_canopy.R")   # canopy functions
library(dplyr)
library(magrittr)

## Re-run fast fits
models <- c("gompertz", "power")
inds <- c("full", "can", "elev")  # independent variable groupings
specs <- c("abba", "beco")
basedir <- paste0("~/work/hh/")
can_func <- "can_hh"
yrs <- c(99, 11)

fits <- list()
for (model in models) {
    moddir <- paste0(basedir, model, "/")
    for (ind in inds) {
        inddir <- paste0(moddir, ind, "/")
        source(paste0(inddir, "model.R"))  # get model and fit function
        for (spec in specs) {
            for (yr in yrs) {
                dat <- prep_hh(dat=tp, yr=yr, spec=spec, can_func=can_func)
                ps <- readRDS(paste0(inddir, tolower(spec), "/", tolower(spec), "_", yr, ".rds"))
                fit <- run_fit(dat, ps, yr)
                name <- paste0(tolower(model),tolower(spec), yr, ind)
                fits[name] <- fit
            }
        }
    }
}
## Compare AICs
aics <- lapply(fits, FUN=function(x) AICc(x, nobs = nrow(dat)))

## LRT
anova(fits[[1]], fits[[3]])  # full model compared to canopy only model
anova(fits[[1]], fits[[5]])  # full -> elev only
