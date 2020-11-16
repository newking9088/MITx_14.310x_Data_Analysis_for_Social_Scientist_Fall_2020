
library(tidyverse)
require(cowplot)

sc <- read_csv("steph_curry_shot_data.csv")
lj <- read_csv("lebron_james_shot_data.csv")
kd <- read_csv("kevin_durant_shot_data.csv")


# CDF comparing Shot distance for Shots made
sc_shot_made <- filter(sc, shot_made==1)
lj_shot_made <- filter(lj, shot_made==1)
kd_shot_made <- filter(kd, shot_made==1)

sc_distance_made<-sc_shot_made$shot_distance
lj_distance_made<-lj_shot_made$shot_distance
kd_distance_made<-kd_shot_made$shot_distance

ggplot(sc_shot_made, aes(shot_distance))+
  stat_ecdf(data=sc_shot_made, aes(shot_distance), color="darkblue" )+
  stat_ecdf(data=lj_shot_made, aes(shot_distance),  color="darkred" )+
  stat_ecdf(data=kd_shot_made, aes(shot_distance),  color="purple" )+
  xlab("Distance to basket for shot made, CDF")+
  ylab("")
ggsave("Comparisonbetweenplayers.pdf")

# alternatively we can first append the three data sets, and then plot

threeplayers<-bind_rows(list( "Stephen Curry"=sc, "Lebron James"=lj, "Kevin Durrant"=kd) , .id="player")
threeplayers_shots_made <- filter(threeplayers, shot_made==1)

ggplot(three_players_shots_made, aes(shot_distance, colour=player))+
  geom_freqpoly()


ggplot(three_players_shots_made, aes(shot_distance, colour=player, y=..density..))+
  geom_freqpoly()

ggplot(three_players_shots_made, aes(shot_distance, colour=player))+
  geom_density(kernel="gaussian")


ggplot(threeplayers_shots_made, aes(shot_distance, colour=player))+
  stat_ecdf()+
  xlab("Distance to basket for shot made, CDF")+
  ylab("")
ggsave("Comparisonbetweenplayers_onedataset.pdf")


# The combined data set also allows to do a comparative boxplot
ggplot(threeplayers_shots_made)+
  geom_boxplot(
    mapping=aes( 
      x = reorder(player, shot_distance, FUN = median),
      y = shot_distance
    )
  )+
  coord_flip()+
  xlab("")+
  ylab("Boxplots of distance of shot made, by player")+
  theme_minimal()
  

  ggsave("boxplot.pdf")


  # test equality of distribution of Curry and others
  
  # first, I extract the vectors
  sc_distance_made<-sc_shot_made$shot_distance
  lj_distance_made<-lj_shot_made$shot_distance
  kd_distance_made<-kd_shot_made$shot_distance
  
  
  # now I run the test
   ks.test(sc_distance_made,lj_distance_made)
  ks.test(sc_distance_made,kd_distance_made)
  
  # is steve curry distribution a normal?
  sc_mean<-mean(sc_distance_made)
  sc_sd<-sd(sc_distance_made)
  
  
  ks.test(sc_distance_made, "pnorm", mean=sc_mean, sd=sc_sd)
  
# two ways density for steve Curry

SC1 <- ggplot(sc, aes(distance_from_midline_feet,distance_from_baseline_feet))+
  geom_bin2d()+
  ylab("from baseline")



SC2 <- ggplot(sc, aes(distance_from_midline_feet,distance_from_baseline_feet))+
  geom_density2d()+
  ylab("from baseline")

plot_grid(SC1, SC2, ncol = 1)
ggsave("stevecurry2d.pdf")



