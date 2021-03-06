# Examples from http://r-statistics.co/R-Tutorial.html


# R ignores everything that comes after the "#"
# This is useful to insert comments that should not be run


# How do I run code? ------------------------------------------------------

# Either, you write code in the console and press "enter"
# Or, you write your code in a script file (.R), move the cursor to the line where the code is, and press
# "ctrl + enter"
# Press "shift + alt + k" for a quick reference of keyboard shortcuts


# Using R as a calculator -------------------------------------------------

2 + 3
3 * 3
sqrt(9)


# Assignment operator "<-" ------------------------------------------------

a <- 2 # a will appear in your environment window and be stored for future use
# or
a = 2

a # run a to display stored value (result will appear in console)

2 <- a    # WILL NOT WORK!

2 + a # use the stored variable "a" for calculation


# Variable types (classes) and data types ---------------------------------------------------

# Variable Types
# 
# character – Strings
# integer – Integers
# numeric – Integers + Fractions
# factor – Categorical variable where each level is a category
# logical – Boolean
# complex – Complex numbers
# 
# Data Types
# 
# vector – A collection of elements of same class
# matrix – All columns must uniformly contain only one variable type.
# data.frame – The columns can contain different classes.
# list – Can hold objects of different classes and lengths


# Handling variable types:

# inspect class
class(a)

# change to character class
a <- as.character(a)
class(a)
a
a + 2 # cannot compute "2" + 2, since a is now a character

# revert class back to a "numeric" class
a <- as.numeric(a)
a + 2 # works!

# Handling data types:
  # vector – A collection of elements of same class
    # Use c() to combine different elements
vector1 <- c(1,4,2,6)
vector1
vector2 <- c(1:4)
vector2
vector0 <- c("a", "b", "c", "d")

vector1 + vector2
2 * vector2

c(vector0, vector1)

cbind(vector0, vector1) # use cbind() to combine objects by columns
data.frame(vector0, vector1) # use data.frame() to create a data frame


# How to install packages -------------------------------------------------

# install.packages("name of package")
# install.packages("car") # package is installed and stored in your library

# how to load the package from the library
library(car) # note the lack of quotation marks

# the package will have different functions that you will be able to use
# car::  # press tab to display list of different functions

# getting help 
?base
library(help = "base")

# the library "base" is already loaded when starting R

mean(c(2,5))
base::mean(c(2,5))


# How to plot data? -----------------------------------------------------

# use ggplot2 package
# install.packages("ggplot2") # install package
library(ggplot2) # load package
# or
# install.packages("tidyverse") # install package
library(tidyverse) # load package


# use a dataset (iris) that comes with the ggplot2 package

iris
head(iris) # only show the first few lines of data frame
View(iris) # View the data frame
str(iris) # inspect the structure of the data frame
summary(iris) # statistical summary of the data frame

?iris # information about the data


ggplot(iris) # blank pane

# add x and y axes using aesthetics (aes())
ggplot(iris, aes(x = Species, y = Sepal.Length))

# add geometries, such as points
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_point()

# or add columns
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_col()

# specify colors for points using color =
ggplot(iris, aes(x = Species, y = Sepal.Length, color = Species)) +
  geom_point()

# specify colors for bars using fill = 
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_col()

# change axis labels and title
ggplot(iris, aes(x = Species, y = Sepal.Length, color = Species)) +
  geom_point() +
  labs(y = "Sepal length (au)", title = "This is a title", color = "This is a legend label")

# Setting up a project file -----------------------------------------------
# Keep all the files associated with a project organized together
# The files can be: input data, scripts, figures etc.


# How do I get my data into R? --------------------------------------------
read.table()
read.csv2()

# more packages available, such as "readxl" specifically for Excel files


# animal.study <- data.frame(Animal = as.factor(rep(1:10, 2)),
#            Weight = c(rnorm(10, 40, 2), rnorm(10, 20, 2)),
#            Surgery = c(rep("pre", 10), rep("post", 10)))
# write.csv(animal.study, file = "animalstudy.csv", row.names = FALSE)

read.table("animalstudy.csv", sep = ",")
read.csv("animalstudy.csv", header = TRUE)

animal.study <- read.csv("animalstudy.csv", header = TRUE)

# How to inspect and plot my imported data --------------------------------------------

View(animal.study)
str(animal.study)
summary(animal.study)

# Another option to get descriptive statistics
# install.packages("pastecs")
library(pastecs) # used for stat.desc function
stat.desc(animal.study$Weight, norm = T)
by(animal.study$Weight, animal.study$Surgery, stat.desc, norm = T)


# plot the data set
ggplot(animal.study, aes(Animal, Weight, color = Surgery)) +
  geom_point()

ggplot(animal.study, aes(Animal, Weight, fill = Surgery)) +
  geom_col()
  
ggplot(animal.study, aes(Animal, Weight, fill = Surgery)) +
  geom_col(position = position_dodge())

ggplot(animal.study, aes(Animal, Weight, fill = Surgery)) +
  geom_col(position = position_dodge())+
  facet_wrap(~Surgery)


# something wrong with the x axis?

str(animal.study)

animal.study$Animal
class(animal.study$Animal) # what type of data is the variable Animal?

# Change Animal variable from an integer variable to a categorical variable (a factor)
animal.study$Animal <- as.factor(animal.study$Animal)  
animal.study$Animal
class(animal.study$Animal)


# Re-run the plots


# Change the theme of the plot
ggplot(animal.study, aes(Animal, Weight, fill = Surgery)) +
  geom_col(position = position_dodge())+
  facet_wrap(~Surgery)+
  theme_dark()


# Use statistics, e.g. mean
ggplot(animal.study, aes(Animal, Weight)) +
  geom_point(aes(color = Surgery))+
  stat_summary(fun = "mean", geom = "point")

# install.packages("forcats")
library(forcats) # load the forcats package (needed for factor manipulation)

ggplot(animal.study, aes(Animal, Weight)) +
  geom_point(aes(color = fct_rev(Surgery)))+  # reverse order of of Surgery variable
  stat_summary(fun = "mean", geom = "point", aes(shape="mean"), color="green")+ # add mean points
  geom_line(aes(group=Surgery, color = Surgery))+
  theme_dark()+ # change theme
  labs(shape="", color="Surgery")


# going back to the iris dataset

ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(color = Sepal.Length))

ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(color = Species))

ggplot(iris, aes(Sepal.Length, Sepal.Width, label =Sepal.Width))+
  geom_point(aes(color = Species))




# Animating a graph -------------------------------------------------------

library(gganimate)

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(aes(colour = Species, group = 1L), size = 2, alpha = 0.5)+
  transition_states(Species,
                    transition_length = 2,
                                 state_length = 1)


# Manipulate several files at once (advanced example - only a showcase) ----------------------------------------


# first load the following packages (some should already have been loaded)
library(tidyverse)
library(reshape2)
library(lubridate)
library(scales)



folderpath <-"Loading curves" 
# the folder "Loading curves" has to be in the working directory

files <- list.files(path = folderpath, 
                    pattern = "*.txt", 
                    full.names = TRUE, 
                    recursive = FALSE)

files

# for loop
# for (i in files[1:2]){  # select only the first two files
for (i in files){  # all files
  df<-read.delim(i,  header = TRUE, sep = "\t")  
  
  # rename loading curve variables
  df<-df %>%  
    dplyr::rename(`Loading curve 1` =  Loading1..N.,
                  `Loading curve 2` =  Loading2..N.,
                  `Loading curve 3` =  Loading3..N.,
                  `Loading curve 4` =  Loading4..N.)
  
  
  df$Time<-as.POSIXct(strptime(df$Time, format="%H:%M:%OS")) # convert time to POSIX format
  
  # melt to data frame to long format
  df_long<-melt(df, 
                id = c("Time"), 
                measure = c("Loading curve 1", 
                          "Loading curve 2", 
                          "Loading curve 3", 
                          "Loading curve 4")) 
  
  # create plot
  myplot<-
    ggplot(df_long)+
    geom_line(aes(Time,  value, color = variable))+
    geom_point(aes(Time,  value, color = variable))+
    facet_wrap(~variable, ncol = 1)+
    stat_smooth(aes(Time, value, linetype = "Smooth") )+
    scale_x_datetime(breaks = date_breaks("5 min"), labels = date_format("%H:%M"))+
    labs(x = "Time", 
         y = "Load (N)", color="Loading station",
         linetype = "", 
         title = gsub("^.*?/ *(.*?) *.txt","\\1", i))+  # only use part of the file name for the title
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))+
    theme_bw()+
    coord_cartesian(ylim = c(-0.5, 4))
  # coord_cartesian(ylim = c(-0.5, max(df_long$value)))
  
  # save plot to the folder
  ggsave(myplot,   
         path = folderpath, 
         file = paste0(gsub("^.*?/ *(.*?) *.txt","\\1", i), ".png"), 
         scale = 2)
  # print(myplot) # within a for loop, one requires to force the print
}


# Reproducible science using RMarkdown -----------------------------------

# https://rmarkdown.rstudio.com/
  

# Deploying web apps with Shiny -------------------------------------------

# https://shiny.rstudio.com/
  