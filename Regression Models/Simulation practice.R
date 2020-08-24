library(UsingR)
data(diamond)
y <- diamond$price
x <- diamond$carat
n <- length(y)
fit <- lm(y~x, diamond)
e <- resid(fit)
yhat <- predict(fit)
max(abs(e-(y-yhat)))

plot(diamond$carat, diamond$price,
     bg = "lightblue",
     col = "black", cex = 1.1, pch = 21, frame = F)
abline(fit, lwd = 2)
for (i in 1:n){
    lines(c(x[i],x[i]),c(y[i],yhat[i]), col = "red", lwd = 2)
}
lines(c(0.2,0.3), c(200,600), col = "green")

plot(x,e, bg = "lightblue", col = "black", cex = 2, pch = 21, frame = F)
abline(h = 0, lwd = 2)

for (i in 1:n){
    lines(c(x[i], x[i]), c(e[i], 0), col = "red", lwd = 2)
}

for (i in 1:n){
    lines(c(0,x[i]), c(y[i], y[i]), col = "green", lwd = 2)
}

for (i in 1:n){
    lines(c(0, x[i]), c(e[i], e[i]), col = "red", lwd = 2)
}




x <- rnorm(10)+5
y <- x + rnorm(10)
plot(x,y, type = "n")
for(i in 1:length(x)){
    lines(c(0, x[i]), c(y[i], y[i]), col = "pink", lwd = 2, lty = 3)
    lines(c(x[i], x[i]), c(0, y[i]), col = "pink", lwd = 2, lty = 3)
}
points(x,y, pch = 19, col = "hotpink")
abline(lm(y ~ x), col = "brown", lwd = 2)
     