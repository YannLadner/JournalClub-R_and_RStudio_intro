# Examples from http://r-statistics.co/R-Tutorial.html


# R ignores everything that comes after the "#". This is useful to insert comments that should not be run.



# Using R as a calculator -------------------------------------------------

2 + 3
3 * 3
sqrt(9)


# Assignment operator "<-" ------------------------------------------------

a <- 2
# or
a = 2

2 <- a    # WILL NOT WORK!

2 + a


# Classes or data types ---------------------------------------------------

# inspect class
class(a)

# change class
a <- as.character(a)
a
a + 2 # cannot compute "2" + 2, since a is now a character

# revert class back to a "numeric" class
a <- as.numeric(a)
a + 2 # works!


# How do I get my data into R? --------------------------------------------


