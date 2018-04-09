# Introduction to Data Wrangling in R: Importing, Reshaping, Visualizing Data

## Before the workshop:
### 1)Download and install R and RStudio
Follow the below links download and install the appropriate version of R and R Studio for your operating system
* [R](https://www.r-project.org)
* [RStudio](https://www.rstudio.com/products/RStudio/)

### 2)Download the files in this repository to your desktop 
Download the workshop files by clicking the green "clone or download" button and then click "Download ZIP". Move the resulting folder to your desktop.

### 3)Download the workshop data
Download the data we will use in the workshop from the below link. The resulting file should be a compressed "2008.csv.bz2" file. Uncompress the file and move the file into the R_Workshop folder on your desktop. Once it is uncompressed you should have a 689.4mb file named "2008.csv" in R_Workshop folder. 
* [2008 Flight Data](http://stat-computing.org/dataexpo/2009/2008.csv.bz2)

## Opening R, setting working directory, Base R, downloading & loading packages
* [Base R - Cheatsheet](http://github.com/rstudio/cheatsheets/raw/master/base-r.pdf)
* [R Studio - Cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf)

- R has a "working drectory" which is the folder where R will load data from and write files out to; You will need to set the working directory in the R GUI, the R-Studio GUI or by writing in the command line: 

`setwd("~/Desktop/R_Workshop")`

- The utility of R is in the hundereds of packages which offer thousands of pre-made functions. Packages will need to be installed; you can install them in the R GUI, the R-Studio GUI or by writing in the command line:

`install.packages("data.table")`

- Once packages are installed you will still need to load them in order to use their functions; you can load them with the 'library()' function:

`library(data.table)`

- This workshop will leverage functions from several packages, you can install and load all of them with the following command:

`source("Workshop_Packages.R")`

## Data Structures,Loading Data, Indexing & Functions

- R has some basic data structures we will primarily use just two, vectors and data_tables

`Vec <- 7` #this is a vector

`num_Vec <- c(1,2.5,3,4.7)` #this is also a vector

`Log_Vec <- c(TRUE,TRUE,FALSE,TRUE)` #this is a vector of logical statements

`Chr_Vec <- c("This", "is a", "character", "vector")` #this is a character vector

`DT1 <- data.table(V1=num_Vec,V2=Log_Vec,V3=Chr_Vec)` #DT1 is now a data.table

`str(DT1)` #the str() function will tell you about the types of each column in a data.table

- Indexing allows you to retrieve values or subset a data_table

`DT1[1,]` #returns the first row, notice that this is a data_table 

`DT1[,V2]` #returns the column named "V2", notice that this is a vector 

- ".csv" files are a common way to store data, we can load ".csv" files with the fread() function:

`DT<-fread("2008.csv")`

- We can now look at the data with some useful functions

`DT` # this is okay with a data_table but it is bad practice

`head(DT)`

`tail(DT)`

`str(DT)` # we learned about data types above, this is a useful way to inspect a data object and see column types

## Data Wrangling

- Data Wrangling is the process of reshaping, transforming and merging data. 

### Data Wrangling Package Cheetsheets
* [datatables](https://github.com/Rdatatable/data.table/wiki/Getting-started)([cheatsheet](http://datacamp-community.s3.amazonaws.com/6fdf799f-76ba-45b1-b8d8-39c4d4211c31))([cheatsheet2](https://s3.amazonaws.com/assets.datacamp.com/img/blog/data+table+cheat+sheet.pdf))
* [dplyr](http://dplyr.tidyverse.org)([cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf))
* [reshape2](https://cran.r-project.org/web/packages/reshape2/reshape2.pdf)([cheatsheet](http://rstudio-pubs-static.s3.amazonaws.com/14391_c58a54d88eac4dfbb80d8e07bcf92194.html))

### Data Wrangling with data.table

## Dates and Strings with lubridate and stringr
* [lubridate - Cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/lubridate.pdf)
* [stringr - Cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/strings.pdf)

## Data Visualization with ggplot2
* [ggplot2 - Cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf)
