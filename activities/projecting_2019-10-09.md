I’m not projecting, YOU’RE PROJECTING
================

## What’s the plan?

In this activity, we’re going to create a new RStudio project, add a
basic skeleton of folders to it, then download some real world data and
try to clean it up. Our example data are observations of the Corruption
Perceptions Index by country by year between 1998 and 2015.

## Creating the project

1.  Click file \> new project
2.  Create the project in a new directory
3.  Name the project something appropriate
4.  Set up your folders

<!-- end list -->

  - R: where your R scripts live (all of them)
  - data: where all of the data lives (ALL OF IT)
      - raw: fresh files, completely untouched
      - clean: your clean analysis data sets
  - output: where all the direct pieces of output you make live

<!-- end list -->

5.  Celebrate\!

## Do some stuff\!\!

### Download the data

Click [here](https://datahub.io/core/corruption-perceptions-index) to
navigate the dataset’s landing page on datahub.io. Once there, download
the csv version of the data to your data/raw folder.

### Make a script

Make a new script in your R folder. Call it something like
“clean-data.R”. The script should do the following:

  - Tidy the dataset so that year is a variable
  - Remove any rows with missing values (after you’ve tidied it)
  - Deal with the apparent change of units from 2012 onward (scores
    appear to be multiplied by 10)
  - Save your tidy data set in the clean folder with a sensible name
  - Make a summary table that is interesting in some way.
