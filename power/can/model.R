### model.R --- 
## Filename: model.R
## Description: power model w/ canopy height only
## Author: Noah Peart
## Created: Tue Mar 31 14:41:24 2015 (-0400)
## Last-Updated: Tue Mar 31 14:55:05 2015 (-0400)
##           By: Noah Peart
######################################################################
library(bbmle)

# log likelihood function
normNLL <- function(params, x, dbh, canht) {
    sd = params[["sd"]]
    mu = do.call(pow, list(params, dbh, canht))
    -sum(dnorm(x, mean = mu, sd = sd, log = TRUE))
}

## Power allometry model with only canopy height
## alpha = a + b*canht
## beta = ap + bp*cant
## gamma = intercept (set to DBH height)
pow <- function(ps, dbh, canht) {
    a = ps[["a"]]
    b = ps[["b"]]
    ap = ps[["ap"]]
    bp = ps[["bp"]]
    gamma = 1.37
    alpha = a + b*canht
    beta = ap + bp*canht
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
                        data = list(x = dat[, ht], dbh=dat[, dbh], canht=dat[, "canht"]),
                        method = method,
                        control = list(maxit = maxit)))
    return( fit )
}
