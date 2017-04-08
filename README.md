# Read Me

In its scope, the project [COHESIFY - The Impact of Cohesion Policy on EU Identification and is part of Horizon 2020 programme](http://www.cohesify.eu/) strives to explain EU identification in regions (NUTS2) across the EU through the lens of regional characteristics.

Within the project, the present work converts 10 variables (e.g. quality of government, unemployment rate, share of population with tertiary degree, population change) to the aproppriate format for logistic regression and converts them between the different NUTS versions (2006, 2010, 2013). Besides conversion, each variable is tested for missing values, but the reliability of the values themselves was not analysed.

The work is not reporducible per se, because I didn't upload the data sets and it requires a working PostgreSQL database with PostGIS. However, the .Rmd files contain all the code I wrote to process the data (incl. SQL), plus explanations and notes on the choices I made along the way. Its mainly `dplyr` data wrangling though and it certainly could have been written in a neater way...The file `000_main.Rmd` is the main document that is responsible for kniting the chapters together. This file also lists all the R libraries I used and does the post-processing, so to speak. It joines all the variables and weights the relevant ones.
