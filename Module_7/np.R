#packages
library(tidyverse)
library(modelr)
library("np")

#load data
cps<-read.csv("cps_wage_data.csv")


# let's start with a scatterplot

ggplot(data=cps)+
  geom_point(mapping=aes(x=age, y=ln_weekly_earn))

#kind of useless, let's try adding some transparency to rare points

ggplot(data=cps)+
  geom_point(mapping=aes(x=age, y=ln_weekly_earn),
             alpha=1/100)

# still not fabulous, let's try to get the age by 3 years, and plot a boxplot

ggplot(data=cps, aes(x=age,y=ln_weekly_earn))+
  geom_boxplot(aes(group=cut_width(age,3)))



# this is much informative, alternatively we can try to display the same number of points
#in each bin

ggplot(data=cps, aes(x=age,y=ln_weekly_earn))+
  geom_boxplot(aes(group=cut_number(age,15)))

# we seem to see a pattern where the wage increases with age, first steeply and then less

#ggplot can fit this data for us, let's add a smooth function
ggplot(data=cps, aes(x=age,y=ln_weekly_earn))+
  geom_boxplot(aes(group=cut_number(age,15)))+
  geom_smooth()

#what function is used? by default geom_smooth uses a (non parametric) local regression s
#(more on that in a bit), you have
#other choices, for example the best linear regression

ggplot(data=cps, aes(x=age,y=ln_weekly_earn))+
  geom_boxplot(aes(group=cut_number(age,15)))+
  geom_smooth(method="ln", se=FALSE)

# we see that a linear function is not a good fit , but perhaps a square would work?

ggplot(data=cps, aes(x=age,y=ln_weekly_earn))+
  geom_boxplot(aes(group=cut_number(age,15)))+
  geom_smooth(method="ln", formula =y~ poly(x,2), se=FALSE)

ggplot(data=cps, aes(x=age,y=ln_weekly_earn))+
  geom_boxplot(aes(group=cut_number(age,15)))+
  geom_smooth(method="ln", formula =y~ poly(x,2), se=FALSE)+
  geom_smooth(method="ln", formula =y~ splines::bs(x,3), se=FALSE, color="darkred")


# we arenow in good shape to estimate a linear model, with a a constant, age, and age2
# see next session how we estimate it.


# Kernel regression in R: use the np package

attach(cps)

## Oversmoothing
cps_bw_over <- npreg(xdat=age ,ydat=ln_weekly_earn,bws=35,bandwidth.compute=FALSE)
plot(cps_bw_over)

## Under
cps_bw_under <- npreg(xdat=age ,ydat=ln_weekly_earn,bws=0.1,bandwidth.compute=FALSE)
plot(cps_bw_under)

## OK
cps_bw_ok <- npreg(xdat=age ,ydat=ln_weekly_earn,bws=2.5,bandwidth.compute=FALSE)
plot(cps_bw_ok)