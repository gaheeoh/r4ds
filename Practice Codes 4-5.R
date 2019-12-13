# 4 Workflow: basics

# 4.1 Coding basics
# 4.2 What’s in a name?
x <- 12
this_is_a_really_long_name <- 2.5
this_is <- 12
r_rocks <- 2 ^ 3
r_rock
R_rocks
seq(1,10)
x <- "hello world"
y <- seq(1,10,length.out=5)
y

# 4.4 Practice

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
filter(mpg, cyl ==8)
filter(diamonds, carat > 3)

#
# 5 Data transformation
# 5.1.1 Prerequisites

install.packages("nycflights13")
library(nycflights13)
library(tidyverse)


flights
?flights
View(flights)
glimpse(flights)


# 5.2 Filter rows with filter()


jan1 <- filter(flights, month==1, day==1)

(dec25 <- filter(flights,month==12, day==25))


near(sqrt(2) ^ 2, 2)
near(1 / 49 * 49,1)


filter(flights, month == 11 | month == 12)

nov_dec <- filter(flights, month %in% c(11, 12))

filter(flights, month %in% c(11, 12))

# 5.2.3 Missing values


is.na(x)
is.na(paaa)
x <- NA
is.na(x)
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x >1)


5.2.4 Exercises

# Find all flights that
#
# Had an arrival delay of two or more hours
filter(flights, arr_delay >= 120)

# Flew to Houston (IAH or HOU)


filter(flights, dest == "IAH" | dest == "HOU")

filter(flights, dest %in% c("IAH", "HOU"))

# Were operated by United, American, or Delta
glimpse(flights)
glimpse(airlines)
  #opoen database
  View(airlines)
  filter(flights, carrier %in% c("AA", "UA", "DL"))

# Departed in summer (July, August, and# September)
  filter(flights, month %in% c(7, 8, 9))
  filter(flights, month %in% 7:9)
  filter(flights,  between(month, 7,9))
 # Arrived more than two hours late, but didn’t leave late
  filter(flights, arr_delay >= 120 & dep_delay <= 0 )

  # Were# delayed by at least an hour, but made up over 30 minutes in flight
    filter(flights, (arr_delay - dep_delay) < -30 & dep_delay >= 60 )

  # Departed between midnight and 6am (inclusive)
    summary(flights$dep_time)


    filter(flights, dep_time == 2400 | dep_time <= 600)

    #  modulo operator, %%. The modulo operator returns the remainder of division.
    1:10 %% 5

    filter(flights, dep_time %% 2400 <=600)


  # Another useful dplyr filtering helper is # between().
  # What does it do? Can you use it to simplify the code needed to
# answer the previous challenges?
  ?between


# How many flights have a missing dep_time? What other variables are missing?
  filter(flights, is.na(dep_time))

# What might these rows represent?


# Why is NA ^ 0 not missing? Why is NA | TRUE not missing? Why is FALSE & NA not
# missing? Can you figure out the general rule? (NA * 0 is a tricky
# counterexample!)


  #5.3 Arrange rows with arrange(): Order tbl rows by an expression involving its variables.

  arrange(flights, desc(month))
  ?arrange

  #Missing values are always sorted at the end:
  df <- tibble(x = c(5, 2, NA))
  df
  arrange(df, x)
  arrange(df, desc(x))


  arrange(flights, dep_time)
  tail()
  a <- arrange(flights, desc(is.na(dep_time)), dep_time)
View(a)

# Sort flights to find the most delayed flights. Find the flights that left earliest.
  arrange(flights, desc(dep_delay))
  arrange(flights, (dep_delay))

  # Sort flights to find the fastest flights.
  fastest_flights <- mutate(flights, mph = distance / air_time *60)
  fastest_flights <- select(fastest_flights, mph, flight, carrier, origin, dest)
  View(fastest_flights)


    # ?mutate  adds new variables and preserves existing ones;
  arrange(select(flights, carrier, flight, distance, month, year, day), desc(distance))
  select(flights, carrier, flights, distance, month, year, day)


  # 5.4 Select columns with select()

   # Select all columns between year and day (inclusive)
  select(flights, year:day)
  # Select all columns between year and day (inclusive)
  select(flights, year:day)


  # starts_with("abc"): matches names that begin with “abc”.
  #
  # ends_with("xyz"): matches names that end with “xyz”.
  #
  # contains("ijk"): matches names that contain “ijk”.
  #
  # matches("(.)\\1"): selects variables that match a regular expression. This one matches any variables that contain repeated characters. You’ll learn more about regular expressions in strings.
  #
  # num_range("x", 1:3): matches x1, x2 and x3.

  glimpse(flights)
  select(flights, starts_with("d"))
  select(flights, ends_with("e"))
  select(flights, contains("a"))
  select(flights, ends_with("e"))

  # rename
  rename(flights, tail_num = tailnum)

  a <- select(flights, time_hour, air_time, everything())
  glimpse(a)
  glimpse(flights)


  # select dep_time, dep_delay, arr_time, and arr_delay from flights.



  variables <- c("dep_time", "dep_delay", "arr_time", "arr_delay")
  select(flights, one_of(variables))

  vars <- c("year", "month", "day", "dep_delay", "ar")
  select(flights, one_of(vars))
  select(flights, !!!vars)
  select(flights, contains("TIME"))



  #5.5 Add new variables with mutate()

  flights_sml <- select(flights,
                        year:day,
                        ends_with("delay"),
                        distance,
                        air_time
  )

  mutate(flights_sml,
         gain = dep_delay - arr_delay,
         speed = distance / air_time * 60
  )

  # If you only want to keep the new variables, use transmute():

  transmute(flights,
            gain = dep_delay - arr_delay,
            hours = air_time / 60,
            gain_per_hour = gain / hours
  )

  # 5.5.1 Useful creation functions

  # : %/% (integer division) and %% (remainder),
  transmute(flights,
            dep_time,
            hour = dep_time %/% 100,
            minute = dep_time %% 100
  )
  # log: log(), log2(), log10()
  ?log2


  offsets: lead

  ?lag

  lead(c(4,2,3,1,6,8,5,7), 5)   # values after leading to the position 5

  lead(c(4,2,3,1,6,8,5,7))   # values after leading to the position 1

  lag(c(4,2,3,1,6,8,5,7), 2)   # vectors before the position last to 2

  lag(c(4,2,3,1,6,8,5,7), 6)   # vectors before the position last to 6

  (x <- 1:10)

  cumsum(x)
  cummean(x)
