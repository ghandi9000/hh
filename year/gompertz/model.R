### model.R --- 
## Filename: model.R
## Description: Full gompertz (canopy/elevation) and year as indicator
## Author: Noah Peart
## Created: Wed Mar 11 18:09:18 2015 (-0400)
## Last-Updated: Tue Apr  7 11:48:43 2015 (-0400)
##           By: Noah Peart
######################################################################
library(bbmle)

## log likelihood function
normNLL <- function(params, x, dbh, elev, canht) {
    sd = params[["sd"]]
    mu = do.call(gompertz, list(params, dbh, elev, canht))
    -sum(dnorm(x, mean = mu, sd = sd, log = TRUE))
}

## Gompertz allometry model
## yr = 0/1 indicator
## beta = a + a1*elev + a2*canopy + a3*elev*canopy (limit as dbh -> oo)
## alpha = b + b1*elev + b2*canopy + b3*elev*canopy
## gamma = intercept (limit as dbh -> 0)  # set to DBH height = 1.37 meters
gompertz <- function(ps, dbh, elev, canht, yr) {
    a = ps[["a"]]
    a1 = ps[["a1"]]
    a2 = ps[["a2"]]        
    a3 = ps[["a3"]]        
    b = ps[["b"]]
    b1 = ps[["b1"]]
    b2 = ps[["b2"]]        
    b3 = ps[["b3"]]        
    gamma <- 1.37  # set to DBH height
    alpha <- a + a1*elev + a2*canht + a3*elev*canht
    beta <- b + b1*elev + b2*canht + b3*elev*canht

    beta*exp( log(gamma/beta)*exp( -alpha*dbh ) ) * yr
}

## Probably need to run once with simulated annealing to get some reasonable
## parameters, then polish off with nelder-mead if necessary
run_fit <- function(dat, ps, yr, method="Nelder-Mead", maxit=1e5) {
    require(bbmle)
    parnames(normNLL) <- c(names(ps))
    ht <- paste0("HT", yr)
    dbh <- paste0("DBH", yr)
    fit <- mle2(normNLL,
                start = unlist(ps, recursive = FALSE),
                data = list(x = dat[, ht], dbh=dat[, dbh], elev=dat[, "ELEV"],
                canht=dat[,"canht"]),
                method = method,
                control = list(maxit = maxit))
    return( fit )
}
