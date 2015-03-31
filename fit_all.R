### fit_all.R --- 
## Filename: fit_all.R
## Description: Run all fits for HH
## Author: Noah Peart
## Created: Mon Mar 30 18:49:36 2015 (-0400)
## Last-Updated: Mon Mar 30 23:59:29 2015 (-0400)
##           By: Noah Peart
######################################################################
source("~/work/ecodatascripts/vars/heights/prep.R")                 # data prep
source("~/work/ecodatascripts/vars/heights/canopy/load_canopy.R")   # canopy functions
library(dplyr)
library(magrittr)

basedir <- paste0("~/work/hh/")
can_func <- "can_hh"
use_sann <- TRUE                  # whether to use SANN
maxit <- 1e7                      # number of iterations to use for SANN

## Species, years, independent variable groups
inds <- c("full", "can", "elev", "dbh")  # independent variable groupings
spec <- c("beco", "abba")
yrs <- c(99, 11)

fits <- list()  # store fits
for (ind in inds) {
    moddir <- paste0(basedir, ind, "/")
    source(paste0(moddir, "model.R"))                                    # model/fit function for ind. var. group
    
    for (spp in spec) {
        pardir <- paste0(moddir, tolower(spp), "/")                      # parameter directory
        for (yr in yrs) {
            cat(paste("Fitting:", "spec = ", spp, ", ind =", ind, ", year = ", yr, "\n"))
            dat <- prep_hh(dat=tp, yr=yr, spec=spp, can_func=can_func)
            ps <- readRDS(paste0(pardir, tolower(spp), "_", yr, ".rds"))
            fit <- run_fit(dat, ps, yr)                                  # run Nelder-Mead to get current LL
            lik <- logLik(fit)                                           # current likelihood

            if (use_sann) {
                method <- "SANN"
                fit <- run_fit(dat, ps, yr, method=method, maxit=maxit)  # SANN first
                fit <- run_fit(dat, as.list(coef(fit)), yr)              # Nelder-Mead using new coefs
            }            
            
            name <- paste0(tolower(spp), yr, ind)
            fits[name] <- fit

            ## save parameters if better than current
            newLik <- logLik(fit)
            if (newLik > lik) {
                ps <- as.list(coef(fit))
                saveRDS(ps, file=paste0(pardir, tolower(spp), "_", yr, ".rds"))
            }
        }
    }
}

## ## Compare AICs
aics <- lapply(fits, AIC)

## ## LRT
## anova(fits[[1]], fits[[3]])  # full model compared to canopy only model
## anova(fits[[1]], fits[[5]])  # full -> elev only

