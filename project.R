####################################################################
# APPLIED FINANCE Project  
#Path-dependent option pricing with Monte Carlo and Rcpp package Individual home project
# Zhaoshuai Wang 436661                                               
####################################################################

#declaration
####################################################################
#In accordance with the Honor Code, I certify that my answers here are my own work, and I
#did not make my solutions available to anyone else.
####################################################################



#Introduction
####################################################################
# In this project, I will use MC/RCPP to analyze a European style up-and-in put option with a barrier active,
#First I will create an Rcpp package which provides a function returning the Monte Carlo approximation of the
#option theoretical price. Then I will change some parameters to see the relation 
#between the theoretical price of the option and other factors:time to maturity/volatility of the underlying instrument returns/numbers of loops
#And draw some plots.
####################################################################



#Part1
####################################################################
###the theoretical price of this option###

# loading packages
library(tidyverse)
# remove package if it exists ===============================================
remove.packages("myoptionPricer2")
detach("package:myoptionPricer2", unload = TRUE) # if it still is in memory

# install package and load to memory =========================================
# from source
install.packages("mypackages/myoptionPricer2_1.0.tar.gz",
                 type = "source",
                 repos = NULL)

# call the function from the package ========================================

# As far as the barrier level b is concerned,I choose b= 105 
#Other parameters: S0 = 105,  strike price K = 100,annualized volatility rate ¦Ò = 0.22,annualized risk-free rate r = 0.05,time to maturity t = 0.5 as the example:
myoptionPricer2::getBarrierUpandInPutPrice(105, 126, 105, 100, 0.22, 0.05, 0.5,10000)


#Part2
####################################################################
###relation between the theoretical price of the option and time to maturity###

#  build an R wrapping function: option price vs. time to maturity ===========

getMCBarrierUpandInPutPriceWithExpiry <- function (expiry) {
  return(
    myoptionPricer2::getBarrierUpandInPutPrice(105, 126, 105, 100, 0.22, 0.05, expiry,10000)
    )
}

# call the wrapping function 
getMCBarrierUpandInPutPriceWithExpiry(0.5)

# arguments values of values of function 
expiry <- seq(0.01, 1, by = 0.01)
prices <- sapply(expiry, getMCBarrierUpandInPutPriceWithExpiry)

# visualization: options price vs. expiry 
tibble( expiry, prices) %>%
  ggplot(aes(expiry, prices)) +
  geom_point(col = "red") +
  labs(
    x     = "time to maturity",
    y     = "option price",
    title = "price of Barrier UpandIn PutPrice option vs. time  to maturity",
    caption = "source: own calculations with the optionPricer2 package")

#Part3
####################################################################
###relation between the theoretical price of the option and volatility of the underlying instrument returns###

# build an R wrapping function: option price vs. volatility ============
getMCBarrierUpandInPutPriceWithvolatility <- function (volatility) {
  return(
    myoptionPricer2::getBarrierUpandInPutPrice(105, 126, 105, 100, volatility, 0.05, 0.5,10000)
    )
}

# call the wrapping function 
getMCBarrierUpandInPutPriceWithvolatility(0.2)

# arguments values of values of function 
volatility  <- seq(0.01, 1, by = 0.01)
prices <- sapply(volatility, getMCBarrierUpandInPutPriceWithvolatility)

# visualization: options price vs. volatility 
tibble(volatility, prices) %>%
  ggplot(aes(volatility, prices)) +
  geom_point(col = "blue") +
  labs(
    x     = "volatility rate",
    y     = "option price",
    title = "price of Barrier UpandIn PutPrice option vs. volatility rate",
    caption = "source: own calculations with the optionPricer2 package")


#Part4
####################################################################
#### option price vs. number of loops

# 6. build an R wrapping function: option price vs. number of loops ============
getBarrierUpandInPutPriceLoops <- function (loops) {
  return(
    myoptionPricer2::getBarrierUpandInPutPrice(105, 126, 105, 100, 0.22, 0.05, 0.5,loops)
  )
}

# call the wrapping function 
getBarrierUpandInPutPriceLoops(500)

# arguments values of values of function 
loops  <- seq(100, 10000, by = 100)
prices <- sapply(loops, getBarrierUpandInPutPriceLoops)

# visualization: options price vs. numbers of loops 
tibble(loops, prices) %>%
  ggplot(aes(loops, prices)) +
  geom_point(col = "blue") +
  labs(
    x     = "number of loops",
    y     = "option price",
    title = "price of Barrier UpandIn PutPrice option vs. numbers of loops ",
    caption = "source: own calculations with the optionPricer2 package")







  

