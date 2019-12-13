# Introduction

install.packages("tidyverse")
install.packages(c("nycflights13", "gapminder", "Lahman"))


# 3 Datavisualization

library(tidyverse)
mpg
?mpg
ggplot(data=mpg) +  geom_point(mapping = aes(x = displ, y = hwy))


# 3.2 First steps


  # of rows
  nrow(mpg)

  # of cols
  ncol(mpg)

  #data summary: type of each column
  glimpse(mpg)

  # variable frequency table
  count (mpg,drv,class)

  ggplot(mpg, aes(x = class, y = drv)) +
    geom_count()

  mpg %>%
    count(class, drv) %>%
    ggplot(aes(x = class, y = drv)) +
    geom_tile(mapping = aes(fill = n))

  mpg %>%
    count(class, drv) %>%
    complete(class, drv, fill = list(n = 0L)) %>%
    ggplot(aes(x = class, y = drv)) +
    geom_tile(mapping = aes(fill = n))

# 3.3 Asthetic mappings

  # ggplot(data = <DATA>) +
  #   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

  ggplot(data=mpg)+ geom_point(mapping = aes (x=hwy, y=cyl))
  ggplot (data=mpg)+geom_point (mapping =aes(x=class, y=drv))


  ggplot(data=mpg) + geom_point(mapping=aes(x=displ,y=hwy, color=class))

  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, size = class))


  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, alpha = class))


  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, shape = class))
  #  ggplot2 will only use six shapes at a time


  ggplot (data=mpg) +
    geom_point(mapping= aes(x=displ, y=hwy), color= "red", size=1, shape=17)

  ggplot (data=mpg) +
    geom_point(mapping= aes(x=displ, y=hwy, size=fl, shape=fl,color=fl))


  ?geom_point
  ggplot (data=mpg) +
    geom_point(mapping= aes(x=displ, y=hwy, stroke=fl))

  pa<-ggplot(mpg,aes(displ,hwy))

  pa + geom_point(mapping =aes(color=class))

  pa + geom_point(shape=5,stroke=0.7)


  pa + geom_point(mapping =aes(colour = year < 2000))



# 3.5 Facets

  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_wrap(~ class, ncol = 4)

  ?facet_wrap


  pa +
    geom_point() +
    facet_grid(drv ~ cyl)

  mpg

  pa+ geom_point() + facet_grid(drv~cyl)
  ggplot(data = mpg) +
    geom_point(mapping = aes(x = drv, y = cyl))


  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(drv~ cyl)


  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_wrap(drv~ cyl)

  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_wrap(~ class, nrow = 2)


  # 3.6 Geometric objects

  #
  # line chart: geom_line()
  # boxplot: geom_boxplot()
  # histogram: geom_histogram()
  # area chart: geom_area()


  ggplot(data = mpg) +
    geom_smooth(mapping = aes(x = displ, y = hwy))


  pa+ geom_smooth()



  # geom_smooth + geom_point

  ggplot(data = mpg) +
    geom_point(mapping=aes(x = displ, y = hwy,color=drv) ) +
    geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color=drv))


  ggplot(data = mpg) +
    geom_smooth(
      mapping = aes(x = displ, y = hwy,  color=drv),
     #show.legend = FALSE
    )


  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), color="blue") +
    geom_smooth(mapping = aes(x = displ, y = hwy), color="green")

  ?color

  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping=aes(color=class))+
    geom_smooth()

  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping = aes(color = class)) +
    geom_smooth()


  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping = aes(color = class)) +
    geom_smooth(data = filter(mpg, class == "compact"), se = FALSE)

  #3.6.1 Exercise

  #What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
  ggplot(mpg, aes(hwy))+ geom_freqpoly(kernel="gaussian")
  ggplot(mpg, aes(hwy))+ geom_area(stat="bin")



  ggplot(mpg, aes(class,hwy))+geom_boxplot()


  #Run this code in your head and predict what the output will look like. Then,
  #run the code in R and check your predictions.

  ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
    geom_point() +
    geom_smooth(se = FALSE)


  # What does show.legend = FALSE do? What happens if you remove it?
  # Why do you think I used it earlier in the chapter?

  ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
    geom_point(show.legend=FALSE) +
    geom_smooth(se = FALSE,show.legend=FALSE)


  # Will these two graphs look different? Why/why not? same

  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point() +
    geom_smooth(se=FALSE)



  ggplot() +
    geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))



  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point() +
    geom_smooth(aes(group=drv),se=FALSE)

  .


  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(aes(color=drv)) +
    geom_smooth(se=FALSE)


  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(aes(color=drv)) +
    geom_smooth(aes(linetype=drv),se=FALSE)


  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping=aes(fill=drv), shape=21 , size=6, stroke=2,color="white")

  ?ggplot2-specs

  # 3.7 Statistical transformations



  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut))

  ?diamonds

  ?geom_bar

  ggplot(data = diamonds) +
    stat_count(mapping = aes(x = cut))



  demo <- tribble(
    ~cut,         ~freq,
    "Fair",       1610,
    "Good",       4906,
    "Very Good",  12082,
    "Premium",    13791,
    "Ideal",      21551
  )

  ggplot(data = demo) +
    geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")


  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, y = ..count.., group = 1))

  ?geom_bar


  # stat_summary to geom

  ggplot(data = diamonds) +
    stat_summary(
      mapping = aes(x = cut, y = depth),
      fun.ymin = min,
      fun.ymax = max,
      fun.y = median
    )


  ggplot(data = diamonds) +
    geom_pointrange(
      mapping = aes(x = cut, y = depth),
      stat = "summary",
      fun.ymin=min,
      fun.ymax=max,
      fun.y=median
    )

  #3.7.2 What does geom_col() do? How is it different to geom_bar()?



  #geom_col: stat_dentity()
  #geom_bar: stat_bin


  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut))

  ggplot(data = diamonds) +
    geom_col (mapping = aes(x = cut, y= ..prop..))

  ggplot(data = diamonds) +
    stat_bin(mapping = aes(x = cut))

  ?stat_bin

  ?geom_pointrange

  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = color, y = ..prop.., group=1))


  ggplot(data = diamonds) +
    geom_bar(aes(x = cut, y = ..count.. / sum(..count..), fill = color))





  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, colour = cut))


  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = cut))



  # 3.8 Position adjustments

  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = clarity))


  ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
    geom_bar(alpha = 1/5, position = "identity")
  #alpha: transparency

  ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
    geom_bar(alpha = 1/5)


  ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) +
    geom_bar(fill = NA, position = "identity")


  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")


  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

  ?geom_point
  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), position = "identity")


  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_jitter()
  ?geom_jitter

  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_point(position = position_jitter())


  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_jitter(width=0, height=1)


  ggplot(data = mpg, mapping = aes(x = drv, y = hwy, color=class)) +
    geom_boxplot(position="dodge2")


  # 3.9 Coordinate systems

  #coord_flip: switch x-y axis

  ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
    geom_boxplot()

  ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
    geom_boxplot() +
    coord_flip()

  # coord_quickmap: correct aspect ratio for the map

  install.packages("maps")


  nz <- map_data("nz")


  ggplot(nz, aes(long, lat, group = group)) +
    geom_polygon(fill = "white", colour = "black")

  ggplot(nz, aes(long, lat, group = group)) +
    geom_polygon(fill = "white", colour = "black") +
    coord_quickmap()


  install.packages("mapproj")
  ggplot(nz, aes(long, lat, group = group)) +
    geom_polygon(fill = "white", colour = "black") +
    coord_map()

  #coord_polar(): polar coordinate


  bar <- ggplot(data = diamonds) +
    geom_bar(
      mapping = aes(x = cut, fill = cut),
      show.legend = FALSE,
      width = 1
    ) +
    theme(aspect.ratio = 1) +
    labs(x = NULL, y = NULL)


  bar
  bar + coord_flip()
  bar + coord_polar()

  # 3.9.1

  ggplot(mpg, aes(x = factor(1), fill = drv)) +
    geom_bar() +
    coord_polar(theta="y")

  ggplot(mpg, aes(x = factor(1), fill = drv)) +
    geom_bar(width=1) +
    coord_polar()

  # labs  : Axis

  ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
    geom_boxplot() +
    coord_flip() +
    labs(
      y = "Highway MPG",
      x = "Class",
      title = "Highway MPG by car class",
      subtitle = "1999-2008",
      caption = "Source: http://fueleconomy.gov"
    )


  ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
    geom_boxplot() +
    coord_flip() +
    ggtitle("Titlegg")+
    xlab("x axis name hUr")




