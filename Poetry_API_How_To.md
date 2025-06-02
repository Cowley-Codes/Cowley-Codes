# How to run the Poetry Library API #

This document explains how to run the Poetry Library API.

There are 7 files:
1. ```Poetry_API_How_To.md``` - guide, you are here.
2. ```Poetry_Library.sql``` - the SQL database. 
3. ```__init__.py``` - though empty, makes the folder a package.
4. ```config.py``` - stores keys and passwords - **follow instructions below to update**.
5. ```poetry_db_utils.py``` - where the connection to the database and queries are managed.
6. ```poetry_app.py``` - contains API logic.
7. ```poetry_main.py``` - where the client-side functions are defined and expected interaction is simulated.


### config.py ###
The config.py file contains information required to connect to the MySQL server. 

Before trying to run the Python package, you must ensure that these details are correct **for you**.

The values in the config.py file now are just placeholders.

Update with your own host, username and password (your personal password to connect in MySQL)

### Installations ###
There are two installations required in order to run this script. 

These installations are made in the terminal.

Examples here are for Mac and so use pip3 (for Windows use pip).

1. ```pip3 install my-sql-connector``` Installs the sql connector.
    This enables the connection to the database in MySQL. 
    Notice this is then imported into the db_utils file where this connection is managed.

2. ```pip3 install Flask``` Installs Flask, a framework for developing APIs in Python. Notice this is then imported into the app.py file where the API endpoints are managed.

### Running the script ###

1. Ensure that config.py details are correct for you, as described above. 
2. Ensure correct installations are made, as described above. 
3. When working in the terminal to run the app and main files, it is essential that you are in the same directory as where all the files (config, init, main, app, db_utils) are stored. So ensure to change the directory using the ```cd``` command in each of the next two terminal windows to be this directory, you can check that you have all the files in the directory by using ```ls```. 
4. The app.py file must be running in the terminal first and throughout. In a terminal window use command ```python3 poetry_app.py```. 
You will know this is working if the url is returned and you can follow this url in your browser to see ‘The Poetry Library is open!’ **Do not exit this terminal window while running the script.** app.py must remain running for everything else to work. 
5. Open a new window in the terminal. In this new window, run the command ```python3 poetry_main.py```. You will know this is working when the run() begins in the terminal window, the first message is ‘Welcome to the Poetry Library’

### Expected flow of interaction ###

The ```run()``` function in poetry_main.py models how a user would interact with the API. 
The flow of interaction goes thus.

1. The user is welcomed to the library.
2. The user chooses y/n for whether or not they have a book to return.
3. If they select y, they can enter the ID for this book. The corresponding row is deleted from the borrows table in the database, making the returned book available again in the library. This is possible due to the borrowing endpoint with DELETE method. For modelling purposes, book numbers 4, 8 and 24 are already out on loan, so you can return one of these as a demo.
4. If they select n, this step is missed.
5. The user is then shown all the authors in the library. This is possible due to the authors endpoint with GET method. 
6. The user then enters the ID number for their desired author.
7. The program displays the books by that author. This is possible due to the books endpoint with additional id parameter and GET method. 
8. The user then enters the ID for their chosen book. 
9. If the book is available, the program will add a new row to the borrowing table in the database. This row contains the book's ID, the current date, return date in three weeks’ time and the borrower’s name as entered by the user. This is possible due to the borrowing endpoint with POST method.
10. If the requested book is already out on loan, the program replies to the user with the next available date on which they can borrow the book. You can test this using any of the IDs 4, 8 or 24 that you did not return earlier in the simulation.
11. Exception handling throughout ensures that only ID numbers in the valid range for authors (1-10) and books (1-43) will be accepted. You can test this by entering values outside of these ranges to receive the appropriate error message.
12. Finally, the library is declared closed.
