### growth_stages.R --- 
## Filename: growth_stages.R
## Description: variation/slope of growth through size classes
## Author: Noah Peart
## Created: Tue Apr  7 14:53:20 2015 (-0400)
## Last-Updated: Tue Apr  7 15:46:39 2015 (-0400)
##           By: Noah Peart
######################################################################
source("~/work/ecodatascripts/vars/heights/prep.R")                 # data prep/load
library(reshape2)
library(dplyr)
library(ggplot2)

## tidy, wide -> long
yrs <- c(99, 11)
cols <- grep("^STAT|^DBH|^HT|TRAN|TPLOT|TAG|SPEC|ASP", names(tp))
dat <- tp[tp$ELEVCL == "HH", cols]
cols <- grep("[[:alpha::]]*$|.*99$|.*11$", names(dat))
dat <- dat[, cols]  # remove other year columns

dat <- reshape(dat, times = c(99, 11), direction = "long",
               varying = list(
               STAT = grep("^STAT", names(dat)),
               DBH = grep("^DBH", names(dat)),
               HT = grep("^HT[[:digit:]]", names(dat)),
               HTCL = grep("HTCL", names(dat))),
               v.names = c("STAT", "DBH", "HT", "HTCL"),
               timevar = "YEAR")

## Explore variation in size classes
range(dat$DBH, na.rm=T)
ggplot(dat, aes(DBH)) + geom_histogram() + facet_wrap(~ YEAR)
