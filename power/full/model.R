### model.R --- 
## Filename: model.R
## Description: power model w/ canopy height only
## Author: Noah Peart
## Created: Tue Mar 31 14:41:24 2015 (-0400)
## Last-Updated: Tue Mar 31 15:39:37 2015 (-0400)
##           By: Noah Peart
######################################################################
library(bbmle)

# log likelihood function
normNLL <- function(params, x, dbh, elev, canht) {
    sd = params[["sd"]]
    mu = do.call(pow, list(params, dbh, elev, canht))
    -sum(dnorm(x, mean = mu, sd = sd, log = TRUE))
}

## Power allometry model with only canopy height
## alpha = a + b*canht
## beta = ap + bp*cant
## gamma = intercept (set to DBH height)
pow <- function(ps, dbh, elev, canht) {
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

    gamma + alpha*dbh^beta
}

## Probably need to run once with simulated annealing to get some reasonable
## parameters, then polish off with nelder-mead if necessary
run_fit <- function(dat, ps, yr, method="Nelder-Mead", maxit=1e5) {
    require(bbmle)
    parnames(normNLL) <- c(names(ps))
    ht <- paste0("HT", yr)
    dbh <- paste0("DBH", yr)
    summary(fit <- mle2(normNLL,
                        start = unlist(ps,recursive = FALSE),
                        data = list(x = dat[, ht], dbh=dat[, dbh], elev=dat[, "ELEV"],
                                    canht=dat[,"canht"]),
                        method = method,
                        control = list(maxit = maxit)))
    return( fit )
}
