### setup.R --- 
## Filename: setup.R
## Description: Set up data for analysis
## Author: Noah Peart
## Created: Thu Apr  9 17:12:50 2015 (-0400)
## Last-Updated: Thu Apr  9 19:35:28 2015 (-0400)
##           By: Noah Peart
######################################################################
source("~/work/ecodatascripts/vars/heights/prep.R")                # data prep/load
source("~/work/functions/functions-plotting.R")                    # multiplot
source("~/work/ecodatascripts/vars/heights/canopy/load_canopy.R")  # canopies

library(reshape2)
library(dplyr)
library(ggplot2)

## tidy, wide -> long
yrs <- c(99, 11)
cols <- grep("^STAT|^DBH|^HT|TRAN|TPLOT|TAG|SPEC|ASP|ELEV", names(tp))
dat <- tp[tp$ELEVCL == "HH", cols]
cols <- grep("[A-Za-z]+$|.*99$|.*11$", names(dat))
dat <- dat[, cols]  # remove other year columns

dat <- reshape(dat, times = c(99, 11), direction = "long",
               varying = list(
               STAT = grep("^STAT", names(dat)),
               DBH = grep("^DBH", names(dat)),
               HT = grep("^HT[[:digit:]]", names(dat)),
               HTCL = grep("HTCL", names(dat))),
               v.names = c("STAT", "DBH", "HT", "HTCL"),
               timevar = "YEAR")
dat$YEAR <- factor(dat$YEAR)

p99 <- dat[dat$YEAR == 99, ]
p11 <- dat[dat$YEAR == 11, ]

## Add canopy heights
inds <- match(interaction(dat$TPLOT, dat$TRAN, dat$YEAR),
              interaction(hh_plot$TPLOT, hh_plot$TRAN, hh_plot$time))
dat$CANHT <- hh_plot[inds, "ht_mean"]

