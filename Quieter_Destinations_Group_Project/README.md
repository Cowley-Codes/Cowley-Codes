# Quieter Summer Horizons – Finding Peaceful Alternatives for Adventurous Solo Travellers :sunny: :airplane:

Project Overview

This project was created as part of the Code First Girls Data Science course.
Our goal was to recommend quieter, off-the-beaten-path travel destinations for solo travellers who are seeking warm, peaceful summer experiences — as an alternative to crowded tourist hotspots like Greece and Spain.

We focused especially on solo female travellers, providing safe, warm, and welcoming destination recommendations supported by data. 

## Contents of this Repository

This repository includes:

- Stavros/ - all finalised Jupyter notebooks are in this folder

- Stavros/project_data - All CSV files used and created are in this folder

- Stavros/images - All images used are in this folder 

- Solo Traveller Report – A mobile-friendly guide tailored specifically for adventurous solo female travellers.

- Project Report – A detailed explanation of our project goals, data sources, methodology, analysis, and findings.

Key files inside Stavros/:

1. UNWTO Data Cleaning.ipynb – Cleaning of international tourism data.

2. Identifying Tourism Constraints.ipynb - Analysis of international tourism data

4. Weather Data.ipynb – Processing and preparing weather data.

5. The Three Recommended Destinations.ipynb – Filtering top recommended destinations based on weather similarity and tourism volume.

6. Flight Data for Top Destinations.ipynb – Retrieving flight data using the Skyscanner API. 

full_sorted_tourism_with_recommendation.csv – Our final dataset of top destination recommendations.

Other supporting CSV files and notebooks used during the project.

The Solo Female Traveller report and Project report

## How We Worked

- Sourced tourism data from the UNWTO (United Nations World Tourism Organization) dataset.

- Collected weather data for a wide range of countries using the OpenWeather API, focusing on summer conditions similar to Greece.

- Integrated flight data using the Skyscanner API to assess accessibility and affordability.

- Data cleaning, analysis, and final recommendations were completed using Python (Pandas, NumPy, requests, etc.) in Jupyter Notebooks.

We followed an Agile working style with tasks divided across Trello and collaborative coding via GitHub branches.

## Key Findings

We identified several alternative destinations that offer:

- Warm, pleasant summer weather

- Lower tourism volumes compared to traditional hotspots

- Good accessibility for travellers

Our final recommendations prioritise safety, serenity, and solo travel confidence, especially for women travelling alone.

## How to Use This Repository 

1. Clone or download the repository to view all files.

2. All files for our project are in the ‘Stavros’ folder. 

3. Open the ordered Jupyter notebooks (.ipynb files) to explore our data processing and analysis step-by-step.

The repository is structured as follows:

- Stavros/ - all Jupyter notebooks and reports
- Stavros/project_data/ - all CSV files (including datasets obtained and spreadsheets created during the project)
- Stavros/images/ - all images used in reports
  
## Installations ##

There are several installations necessary to run the project code. Please run the below code within your notebook to ensure libraries are installed.
```
!pip install pandas  # For handling dataframes
!pip install numpy  # For mathematical purposes in our analysis and visualisations
!pip install requests  # For making API calls
!pip install the fuzz  # For fuzzy matching of place names
!pip install matplotlib  # For plotting charts and graphs
!pip install seaborn   # For more appealing visualisations
!pip install pandas openpyxl # For handling excel files
!pip install plotly # For interactive visualisation and works well with NumPy and Pandas
```
## Project Data & Downloads ##

At several points in the project it is necessary to store data as xlsx or csv files. In order to ensure smooth running of the file paths involved for reading and writing these files, please ensure you have downloaded the provided folder 'project_data' in the same place where you have all the notebooks from the repository.

Some of the data we use comes from API calls, but there are two files initially stored within the project_data folder:

- UNWTO Tourism Statistics Database. Please ensure this has successfully downloaded in the folder as unwto-all-data-download_2022.xlsx
  
- Coordinate data for longitude and latitude of countries. Please ensure this has successfully downloaded in the folder as countries.csv

The CSV files created during the project have also been saved in the project_data folder. In the Jupyter notebooks, the lines of code that wrote our results to the CSV file have been commented out, to ensure you can view the same results that we had obtained.

## API Keys ##

We have used SkyScanner and OpenWeather APIs to retrieve the rest of the data relevant to our project. Please follow the instructions below to obtain your own keys for these APIs and store them in the variables in the below code cells in order to run the API interactions.

### SkyScanner ###

1. Go to https://rapidapi.com and follow the sign up instructions (or log in if you have an account).
2. Search for "Skyscanner API" in the search bar.
3. Click on the Skyscanner API from the search results, the logo is a blue sunrise.
4. Click the Subscribe button (choose the free plan).
5. After subscribing, you will see your X-RapidAPI-Key and X-RapidAPI-Host e.g. skyscanner89.p.rapidapi.com
6. Open the Flight Data for Top Destinations Jupyter notebook.
7. Copy your API key and paste it inside the quotation marks for RAPIDAPI_KEY
8. Copy your API key and paste it inside the quotation marks for RAPIDAPI_HOST

### OpenWeather ###

1. Go to https://openweathermap.org/api and click ‘subscribe’ under ‘One Call API 3.0’. (This is for a free 1000 calls a day)
2. Fill out your details. It will ask for payment details - a further recommendation to avoid being charged follows
3. Click ‘Pay and subscribe’
4. Once set up, login. (You may need to verify your email before using your API key)
5. To avoid being charged, go to ‘Billing Plans’ located at the top of the page.
6. You should see ‘base plan’ highlighted in green. You can edit your calls per day to be no more than 1000 calls a day, so you will never be able to use more than your free amount.
7. Click on ‘API keys’ at the top of the page, and this is where you can find your API key to insert into the appropriate notebook
8. Open the Weather Data Jupyter notebook.
9. Copy your API key and paste it inside the quotation marks for api_key

## Troubleshooting ##

API Key Issues: Ensure you have correctly inserted your API key in the respective places. If there are issues with the data retrieval, check the API documentation for possible changes.

File Path Issues: If there are errors related to file paths (e.g., CSV or Excel files), double-check that the ‘project_data’ folder is located correctly.

Dependencies: If any packages are not installed, run the !pip install commands in a Jupyter cell.

Refer to the Solo Female Traveller Report for an easily accessible summary of our recommendations.

All data sources are cited, and each notebook contains explanations and comments for easy navigation.

## Acknowledgements

UNWTO – Tourism statistics dataset

Skyscanner API – Flight information

OpenWeather API – Historical weather data

Google for Developers - Coordinates dataset

Code First Girls – For the project framework and support

A special thank you to the members that gave countless hours to put this project together. Thank you Alannah, Claire, Divya, Ellice, Fi, Zarfishan and Brinel. 

✨ Thank you for exploring our project! ✨
