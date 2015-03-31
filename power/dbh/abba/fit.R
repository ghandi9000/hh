### fit.R --- 
## Filename: fit.R
## Description: Fit power (dbh only)
## Author: Noah Peart
## Created: Wed Mar  4 12:52:06 2015 (-0500)
## Last-Updated: Tue Mar 31 18:51:04 2015 (-0400)
##           By: Noah Peart
######################################################################
source("~/work/hh/power/dbh/model.R")                               # model/fit functions
source("~/work/ecodatascripts/vars/heights/prep.R")                 # data prep
source("~/work/ecodatascripts/vars/heights/canopy/load_canopy.R")   # canopy functions
library(dplyr)
library(magrittr)

################################################################################
##
##                                 Run fits
##
################################################################################
## Only 3 trees from 87
base_dir <- "~/work/hh/power/dbh/abba/"
yrs <- c(99, 11)
spec <- c("abba")
can_func <- "can_hh"  # canopy functions defined in canopy directory

for (yr in yrs) {
    dat <- prep_hh(dat=tp, yr=yr, spec=spec, can_func=can_func)
    ps <- readRDS(paste0(base_dir, "abba_", yr, ".rds"))

    method <- "SANN" # "Nelder-Mead"
    maxit <- 1e6

    summary(fit <- run_fit(dat, ps, yr, method=method, maxit=maxit))  # SANN first
    summary(fit2 <- run_fit(dat, as.list(coef(fit)), yr))             # the Nelder-Mead

    ## save parameters
    ps <- as.list(coef(fit2))
    saveRDS(ps, file=paste0(base_dir, "abba_", yr, ".rds"))
}
