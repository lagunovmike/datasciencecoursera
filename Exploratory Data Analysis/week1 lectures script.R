data(airquality)


##### Color difference
with(airquality, plot(Wind, Ozone,  
     main = "Ozone and Wind in New York City",
     type = "n",))
with(subset(airquality, Month == 5),
     points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5),
     points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, 
       col = c("blue", "red"),
      legend = c("May", "Other Months"))

unique(airquality$Month)


##### With a regression line

with(airquality, plot(Wind, Ozone, pch = 18, main = "Ozone and Wind in New York City"))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

##### Multiple Plots
par(mfrow = c(1,2))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

# Another

par(mfrow = c(1,3), mar = c(4,4,2,1),
    oma = c(0,0,2,0))
with(airquality,{
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer = TRUE)
})
