### functions.R --- 
## Filename: functions.R
## Description: Functions for .rmd scripts
## Author: Noah Peart
## Created: Thu Apr  9 18:52:28 2015 (-0400)
## Last-Updated: Thu Apr  9 19:02:41 2015 (-0400)
##           By: Noah Peart
######################################################################

## Quantiles
qFunc <- function(dd, cname) { return( data.frame(x=unlist(quantile(dd[[cname]], na.rm=T))) ) }

## Classify by size classes
classify <- function(dat, probs=c(0, 0.25, 0.5, 0.75, 1.0)) {
    dat[,"HTCL"] <- NA
    dat[,"DBHCL"] <- NA
    qDBH <- quantile(dat[["DBH"]], na.rm=T, probs=probs)
    qHT <- quantile(dat[["HT"]], na.rm=T, probs=probs)
    qDBH[[1]] <- 0  # make sure smallest is included
    qHT[[1]] <- 0
    for (i in 1:(length(probs)-1)) {
        dat[!is.na(dat$HT) & dat$HT > qHT[[i]] & dat$HT <= qHT[[i+1]], "HTCL"] <- i
        dat[!is.na(dat$DBH) & dat$DBH > qDBH[[i]] & dat$DBH <= qDBH[[i+1]], "DBHCL"] <- i
    }
    dat[["HTCL"]] <- factor(dat[["HTCL"]])
    dat[["DBHCL"]] <- factor(dat[["DBHCL"]])
    dat
}
