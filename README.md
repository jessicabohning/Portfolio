# Portfolio Key: 
This repository contains a small selection of projects to demonstrate my abilities in R. This document summarizes the different files/projects contained in this repo.

## Regression Analysis
This project uses the "mtcars" data in R to do regression analysis to determine two things: 1) Is an automatic or manual transmission better for MPG?; and 2) Quantify the MPG difference between automatic and manual transmissions. This project is written in an R Markdown file and saved the knitted docs as .pdf and .html files.

## Machine Learning Project
The goal of this project is to create a machine learning algorithm to predict what particular bicep curl a person is making based on sensor data. The data can be found __[here](http://groupware.les.inf.puc-rio.br/har)__. In this file are the .Rmd, .html, .md, and .pdf files as well as the cached data and the testing and training data files (found in the previously mentioned link).

## Webscrapping_Booking
This file is contains the code and a small sample of data collected for my Booking.com scrapes. The goal of this project is to gain an understanding of how the website is growing based on the number of hotels available on the website. The code works by going to three webpages on the website: 

1) the main page to gather overall stats
2) a country page that lists all of the countries outside of the US and how many properties the website has access to in those locations
3) a US page that lists all of the US hotels available on the website. 

The code grabs the needed data from the three web pages, cleans it up, saves the data daily (as its own, unique file), combines all of the previous days' data into one data frame, and plots the data for analysis in the file "Summary Stats.pdf"

## Webscrapping_Priceline
This file contains the code and a small sample of data collected for my Priceline.com scrapes. The goal of this project is to gain an understanding of how the website is growing based on the number of hotels available on the website. However, there is no webpage on this site that lists the total number of hotels available, so the code grabs the results data from eight locations on various dates. 

There are two relevant .R files here:

1) "Hotel_links.R" creates webpages using the priceline.com base-URL to find hotel results for eight locations for Tuesday nights and Saturday nights one week, two weeks, three weeks, and four weeks in advance (Because the code looks for the number of results listed after a search, there could be a varying number of results depending on how far out the hotel room is needed).
2) "Webscraping_Priceline Hotels.R" uses the urls created in "Hotel_links.R" to get results data. 

The code grabs the needed data from the three web pages, cleans it up, saves the data daily (as its own, unique file), combines all of the previous days' data into one data frame, and plots the data for analysis in the file "Priceline Summary.pdf"
