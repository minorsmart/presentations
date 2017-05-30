buildNormDist <- function(mean, sd) {
  library(ggplot2)
  histData <- data.frame(data = rnorm(n=100000, mean = mean, sd = sd))
  Hist <- ggplot(histData, aes(data)) +
    geom_histogram(fill='tomato', colour="black") +
    coord_cartesian(xlim = c(-100, 100))
  Hist
}

buildNormDist(10, 10)

