# The aim of this code is for users to build a board containing key characteristics of 12 characters from Star Wars,
# including homeworld & films they appear in.

# Users can select characters they would like to feature, or choose to have spaces filled with random characters.
# Two copies of the same board are written to files for printing & playing the game "Guess Who?".


# The requests module allows HTTP requests in Python, here facilitating calls to the API using requests.get()
# This first needs to be installed in the terminal using pip install requests (or pip3 for mac)
# Instructions can be found here https://www.w3schools.com/python/module_requests.asp

import requests

# The random module is a built-in Python module which generates random numbers,
# here used to populate the game board with random characters.

import random

# The tabulate module is used to present the final output in an easy to read & ready to play format.
# This first needs installing in the terminal using pip install tabulate (or pip3 for mac)
# Instructions can be found here https://www.datacamp.com/tutorial/python-tabulate

from tabulate import tabulate

# I am using the Star Wars API with base url
# Documentation can be found here https://swapi.dev/documentation
# This is a free, open source API and no pass key is required.

# Initial call to the API to retrieve character data,
# including how many characters are currently listed.

char_url = "https://swapi.dev/api/people/"
char_response = requests.get(char_url)
chars = char_response.json()

# The API returns a dictionary, the number of
# characters is held under the key "count" and
# the actual character data is a list of dictionaries
# held under the key "results".

on_roll = chars["count"]

# The API skips the number 17, so there are 82 characters, the last of which is no. 83.
# This is reflected in later loops since we must iterate through 1-83 and use "if" & "pass" to ignore value 17.

print(f"Welcome to Guess Who STAR WARS Edition! "
      f"To start the fun - build your own board from a whopping {on_roll} characters! \n"
      "Get ready to choose your 12 characters... \n")

# To avoid complications from spelling errors, users will choose characters
# by their id number. The below function is used to present only the id number
# and name of each character in a readable manner, for selection by the user.

characters = chars["results"]

def find_ids(people):
    char_pairs = []
    id_and_name = ""
    for person in people:
        name = person["name"]
        ident_no = person["url"].split("/")[-2]
        # String splitting and slicing are used to isolate the numbers found at the
        # end of the character urls returned by the API e.g.https://swapi.dev/api/people/13/ which
        # has penultimate string "13" when split using "/"
        char_pair = f"{ident_no} : {name}"
        char_pairs.append(char_pair)
        delimiter_space = "  "
        id_and_name = delimiter_space.join(char_pairs)
    print(id_and_name + "\n")
    return id_and_name

find_ids(characters)

# Since the API separates the character data results into pages of 10,
# the following loop is used to retrieve all character data from the API.
# The lists from each page are joined together using + so that the final
# list stores a dictionary of info for each character.

# The number and name pairs for each character are printed in readable lines
# for the user, by calling the above function at the end of each page.


while len(characters) < on_roll:
    next_page = chars["next"]
    char_url = next_page
    char_response = requests.get(char_url)
    chars = char_response.json()

    new_chars = chars["results"]
    characters = characters + new_chars

    find_ids(new_chars)


# Users can now choose id numbers to fill up their board of 12 characters.
# While loop ensures this limit is not exceeded.
# At any point the user can opt to have remaining spaces randomly filled by entering 0.
# If statements ensure the entry is appropriately added/ignored/initiates the random filling of empty spaces.
# Pass is used where values should not be included or interrupt the loops.

character_list = []

while len(character_list) < 12:

    id_number = input("To choose a character, please enter their number. \n"
                      "If you would like to fill the rest of the places with random characters, enter 0: ")

    if id_number == "17":
        pass
    elif int(id_number) in range(1, len(characters) + 2) and not character_list:
        character_list.append(id_number)
    elif id_number == "0":
        while len(character_list) < 12:
            r = random.randint(1, len(characters) + 2)
            r = str(r)
            if r == "17":
                pass
            elif r not in character_list:
                character_list.append(r)
            else:
                pass
        break
    else:
        pass

# Homeworld is a desired characteristic for the board game.
# However, this info is given as an url from the people section
# of the API so a new call to the planets section retrieves planet name data.

planets_url = "https://swapi.dev/api/planets/"
planets_response = requests.get(planets_url)
planets = planets_response.json()

planet_list = planets["results"]

universe = planets["count"]

# The planet data is also separated into pages by the API, so
# another loop is used to create a full list of planets.

while len(planet_list) < universe:
     next_page = planets["next"]
     planet_url = next_page
     planet_response = requests.get(planet_url)
     planets = planet_response.json()
     planet_list = planet_list + planets["results"]

# This function iterates over the planets to find the name of a character's homeworld.

def find_home(wanderer):
    for planet in planet_list:
        if wanderer["homeworld"] == planet["url"]:
            home = planet["name"]
            return home
        else:
            pass


# Similarly, film appearances is a desired characteristic for the board game.
# However, this info is given as an url from the people section
# of the API, so a new call to the films section retrieves film name data.

films_url = "https://swapi.dev/api/films/"
films_response = requests.get(films_url)
films = films_response.json()

films_list = films["results"]

# This function iterates over the films, adding the name of any in which a character appears to their individual list.
# Their lists are then joined into a string separated by new lines for readability in the final output.

def find_films(actor):
    my_films = []
    for film in films_list:
        if film["url"] in actor["films"]:
            my_films.append(film["title"])
        else:
            pass
    delimiter_line = "\n"
    appears_in = delimiter_line.join(my_films)
    return appears_in

# This function returns a list of the character's characteristics.
# Data from the API is refined, using keys to choose from the character dictionaries
# only certain characteristics desired for game play.
# The above functions are called to find the names of the character's world and films.

def get_characteristics(profile):
    name = profile["name"]
    birth = profile["birth_year"]
    home = find_home(profile)
    skin = profile["skin_color"].title()
    eyes = profile["eye_color"].title()
    appearances = find_films(profile)
    return [name, birth, home, skin, eyes, appearances]

# This for loop iterates through the list of all characters, searching for
# id numbers contained in the list chosen by the user.
# The if statement calls the above function to add the character to the board if they have been chosen.
# Else again uses pass as all characters with an id number not in the list should be ignored.

board = []
for character in characters:
    id_no = character["url"].split("/")[-2]
    if id_no in character_list:
        facts = get_characteristics(character)
        board.append(facts)
    else:
        pass

# Using the imported module tabulate to create a table of the chosen characters
# Headers are the characteristics as returned by the function.
# Aligned to fit nicely on the page in an easy-to-read and ready-to-play manner.

guess_who_grid = tabulate(
    board,
    headers=["Name", "Birth Year", "Homeworld", "Skin Colour", "Eye Colour", "Appears in: "],
    tablefmt="fancy_grid",
    numalign="center",
    stralign="left",
    colalign=("center", "center", "center", "center", "center", "left")
)

print(guess_who_grid)

# Two identical grids, one for each player, are written to text files which include instructions.

instructions = """ INSTRUCTIONS
1. Secretly choose your character and mark with a star on your board. Your opponent will do the same.
2. Take it in turns asking yes/no questions to one another.
3. Use a process of elimination to narrow down who their character might be.
4. The first player to correctly identify the other's character is the winner! \n
"""

for i in range(1,3):
    with open(f"Player_{i}.txt", "w") as board_i:
        board_i.write(instructions)
        board_i.write(guess_who_grid)

print("Your boards are ready. \n"
      "Open player 1 & 2 files to print your boards & play.\n"
      "Happy Guessing!")
