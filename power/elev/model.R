### model.R --- 
## Filename: model.R
## Description: power allometric model with only elevation (no canopy)
## Author: Noah Peart
## Created: Wed Mar 11 18:09:18 2015 (-0400)
## Last-Updated: Tue Mar 31 17:27:20 2015 (-0400)
##           By: Noah Peart
######################################################################
library(bbmle)

# log likelihood function
normNLL <- function(params, x, dbh, elev) {
    sd = params[["sd"]]
    mu = do.call(pow, list(params, dbh, elev))
    -sum(dnorm(x, mean = mu, sd = sd, log = TRUE))
}

## Gompertz allometry model with only elevation
## beta = (a + b*elev) is asymptote (limit as dbh -> oo)
## gamma = intercept (limit as dbh -> 0)
pow <- function(ps, dbh, elev) {
    a = ps[["a"]]
    b = ps[["b"]]
    ap = ps[["ap"]]
    bp = ps[["bp"]]
    gamma <- 1.37

    alpha <- a + b*elev
    beta <- ap + bp*elev
    alpha*dbh^beta + gamma
}

## Probably need to run once with simulated annealing to get some reasonable
## parameters, then polish off with nelder-mead if necessary
run_fit <- function(dat, ps, yr, method="Nelder-Mead", maxit=1e5) {
    require(bbmle)
    parnames(normNLL) <- c(names(ps))
    ht <- paste0("HT", yr)
    dbh <- paste0("DBH", yr)
    fit <- mle2(normNLL,
                start = unlist(ps,recursive = FALSE),
                data = list(x = dat[, ht], dbh=dat[, dbh], elev=dat[, "ELEV"]),
                method = method,
                control = list(maxit = maxit))
    return( fit )
}
