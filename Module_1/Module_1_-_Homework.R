#Question 12
print("Hello world!")
paste("Hello", "world!",sep="")

#Question 13
z<- c(pi, 205, 149, -2)
y <- c(z, 555, z)
y<- 2 * y + 760
my_sqrt <- sqrt(y-1)

#Question 14
0/0

#Question 15
#a is a missing value and we add 2 to it
a<- NA
a + 2

#Question 16
age<- c(12, 28, 35, 27, NA, 25, 32, 45, 31, 23, NA, 34)
age[-c(5, 11)]
age[c(-5, -11)]
age[c(1,2,3,4,6,7,8,9,10,12)]
age[!is.na(age)]

#Question 17
library(tidyverse)

papers <- as_tibble(read_csv("[INSERT FILE PATH]"))

papers_select <- select(papers, journal,year,cites,title,au1)

#Question 18
summary(filter(papers,cites >=100))

#Question 19
summarize(group_by(papers,journal), sum_ci=sum(cites))

#Question 20
n_distinct(papers$au1)

#Question 21
papers_female <- select(papers,contains("female"))
