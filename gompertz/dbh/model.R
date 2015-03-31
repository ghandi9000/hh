### model.R --- 
## Filename: model.R
## Description: 
## Author: Noah Peart
## Created: Mon Mar 30 19:14:36 2015 (-0400)
## Last-Updated: Mon Mar 30 19:19:49 2015 (-0400)
##           By: Noah Peart
######################################################################
library(bbmle)

# log likelihood function
normNLL <- function(params, x, dbh) {
    sd = params[["sd"]]
    mu = do.call(gompertz, list(params, dbh))
    -sum(dnorm(x, mean = mu, sd = sd, log = TRUE))
}

## Gompertz allometry model with DBH only
## beta = (a + b*cant) is asymptote (limit as dbh -> oo)
## gamma = intercept (limit as dbh -> 0)
gompertz <- function(ps, dbh) {
    a = ps[["a"]]
    b = ps[["b"]]
    gamma <- 1.37
    a*exp(log(gamma/a)*exp(-b*dbh))
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
                        data = list(x = dat[, ht], dbh=dat[, dbh]),
                        method = method,
                        control = list(maxit = maxit)))
    return( fit )
}
