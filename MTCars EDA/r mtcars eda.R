

##Get the data
mtcars
##Get the dimension of the data
dim(mtcars)
##Get the names of the features 
names(mtcars)

##get the type of attribute of the features
str(mtcars)
##first five rows
head(mtcars)
##last five rows
tail(mtcars)
# To get more information about the dataset
?mtcars
##data preprocessing

#To see the number of rows
nrow(mtcars)

# To see the number of columns
ncol(mtcars)

# To perform the 5 number summary on the entire dataset
summary(mtcars)


# for the miles per gallon(mpg) data
mode_mpg <- names(sort(-table(mtcars$mpg)))[1]
mode_mpg
paste("the mode of the miles per gallon is", mode_mpg)  

#for the cylinder(cyl) data
mode_cyl <- names(sort(-table(mtcars$cyl)))[1]
mode_cyl
paste("the mode of the cylinder is", mode_cyl)  

#for the displacement data
mode_disp <- names(sort(-table(mtcars$disp)))[1]
mode_disp
paste("the mode of the displacement is", mode_disp)  

#for the gross horsepower data
mode_hp <- names(sort(-table(mtcars$hp)))[1]
mode_hp    
paste("the mode of the Horsepower is", mode_hp)  

#for the rear axle ratio (drat)
mode_drat <- names(sort(-table(mtcars$drat)))[1]
mode_drat
paste("the mode of the rear axle ratio is", mode_drat)  

#for the weight
mode_wt <- names(sort(-table(mtcars$wt)))[1]
mode_wt
paste("the mode of the weight is", mode_wt)  

#for the 1/4 mile time
mode_qsec <- names(sort(-table(mtcars$qsec)))[1]
mode_qsec
paste("the mode of the quarter mile is", mode_qsec)  

#for the engine
mode_vs <- names(sort(-table(mtcars$vs)))[1]
mode_vs
paste("the mode for the engine type is", mode_vs)    

#for the transmission
mode_am <- names(sort(-table(mtcars$am)))[1]
mode_am
paste("the most automatic transmission type is", mode_am)    

#for the number of forward gears
mode_gear <- names(sort(-table(mtcars$gear)))[1]
mode_gear
paste("the mode for the number of forward gear is", mode_gear)    

#for the number of carburetors
mode_carb <- names(sort(-table(mtcars$carb)))[1]
mode_carb
paste("the mode for the number of carburetors is", mode_carb)  


mtcars$vs = factor(mtcars$vs)
mtcars$am = factor(mtcars$am)
mtcars$cyl = factor(mtcars$cyl)
mtcars$gear = factor(mtcars$gear)
mtcars$carb = factor(mtcars$carb)
str(mtcars)


###counting
table(mtcars$vs)
table(mtcars$am)
table(mtcars$cyl)
table(mtcars$gear)
table(mtcars$carb)


##summary
summary(mtcars$mpg)
summary(mtcars$disp)
summary(mtcars$drat)
summary(mtcars$wt)
summary(mtcars$hp)
summary(mtcars$qsec)

#library
library('ggplot2')

#barchart categorical features
ggplot(as.data.frame(table(mtcars$vs)), aes(x = Var1, y = Freq))+geom_bar(stat = 'identity')
ggplot(as.data.frame(table(mtcars$am)), aes(x = Var1, y = Freq))+geom_bar(stat = 'identity')
ggplot(as.data.frame(table(mtcars$cyl)), aes(x = Var1, y = Freq))+geom_bar(stat = 'identity')
ggplot(as.data.frame(table(mtcars$gear)), aes(x = Var1, y = Freq))+geom_bar(stat = 'identity')
ggplot(as.data.frame(table(mtcars$carb)), aes(x = Var1, y = Freq))+geom_bar(stat = 'identity')

#line chart for numerical data
ggplot(data = mtcars, aes(x = seq(1, nrow(mtcars)), y = mpg)) + geom_line(aes(group = 1))
ggplot(data = mtcars, aes(x = seq(1, nrow(mtcars)), y = disp)) + geom_line(aes(group = 1))
ggplot(data = mtcars, aes(x = seq(1, nrow(mtcars)), y = hp)) + geom_line(aes(group = 1))
ggplot(data = mtcars, aes(x = seq(1, nrow(mtcars)), y = drat)) + geom_line(aes(group = 1))
ggplot(data = mtcars, aes(x = seq(1, nrow(mtcars)), y = wt)) +geom_line(aes(group = 1))
ggplot(data = mtcars, aes(x = seq(1, nrow(mtcars)), y = qsec)) + geom_line(aes(group = 1))


##histogram
ggplot(data = mtcars, aes(x = mpg)) + geom_histogram(binwidth = .5)
ggplot(data = mtcars, aes(x = disp)) + geom_histogram(binwidth = .5)
ggplot(data = mtcars, aes(x = hp)) + geom_histogram(binwidth = .5)
ggplot(data = mtcars, aes(x = drat)) + geom_histogram(binwidth = .5)
ggplot(data = mtcars, aes(x = wt)) + geom_histogram(binwidth = .5)
ggplot(data = mtcars, aes(x = qsec)) + geom_histogram(binwidth = .5)


###boxplot
ggplot(mtcars, aes(x = factor(mtcars$vs), y = mpg)) + geom_boxplot()
ggplot(mtcars, aes(x = factor(mtcars$carb), y = disp)) + geom_boxplot()
ggplot(mtcars, aes(x = factor(mtcars$vs), y = hp)) + geom_boxplot()
ggplot(mtcars, aes(x = factor(mtcars$vs), y = drat)) + geom_boxplot()
ggplot(mtcars, aes(x = factor(mtcars$vs), y = wt)) + geom_boxplot()
ggplot(mtcars, aes(x = factor(mtcars$vs), y = qsec)) + geom_boxplot()


####scatterplots
ggplot(mtcars, aes(x = mpg, y = disp )) + geom_point(shape = 1)
ggplot(mtcars, aes(x = mpg, y = disp, color = factor(mtcars$vs))) + geom_point(shape = 1)

#### Correlation plot for the mcars dataset

M <- cor(mtcars)
corrplot::corrplot(M,  method = 'square') 
corrplot(M, type = "lower")  
corrplot.mixed(M, lower.col = "black", number.cex = .9)