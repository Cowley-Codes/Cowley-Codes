# This file contains the client-side of interacting with the API using the endpoints from app.py

import requests # This enables interaction with the API
from pprint import pprint # Used to make some results print in a more readable way.

# This first function displays the authors, using the URL from the authors endpoint.

def display_authors():
    result = requests.get(
        f'http://127.0.0.1:5000/authors',
        headers={'content-type': 'application/json'}
    )

    author_list = result.json() # So we have the authors information from the API in json format.

    # Authors info is stored in separated cells in the DB for normalisation.
    # Even in json format this looks awkward, so the below loop is used to make the same list in a more readable way.
    authors = []
    for author in author_list:
        auth = f'{author[0]}: {author[1]} {author[2]}'
        authors.append(auth)

    return pprint(authors)

# The library holds authors with ID from 1-10.
# The below function is used in validating the ID entered by the user within the next function.
# This way any errors caused by incorrect input can be handled.

def author_id_validation(num):
    if num < 0:
        raise ValueError('Author ID must be positive.')

    assert 1 <= num <= 10, 'We currently hold authors 1-10 only.'

    return True

# This first function displays the books by a given author, using the URL from the books endpoint.
# Author validity is initially false and the user is asked to input an author ID.
# The author validation function above is then used, raising the exceptions for invalid input.
# Only if no exceptions occur is the input accepted as a valid author and the API interaction goes ahead.

def get_books_by_author():
    valid_author = False
    try:
        num = int(input('Please enter the number for your chosen author: '))
        author_id_validation(num)

    except ValueError:
        print('Invalid input: ID must be a positive integer.')

    except AssertionError:
        print(f'Must enter an author ID within range 1-10.')

    else:
        valid_author = True
        result = requests.get(
                f'http://127.0.0.1:5000/books/{num}',
                 headers={'content-type': 'application/json'}
            )

        books_list =  result.json()

        # Again a similar loop is used to make the information in the books list more readable.
        books = []
        for book in books_list:
            book_info = f'{book[0]}' + ': ' + book[1] + ' -- ' + book[2]
            books.append(book_info)

        return pprint(books)

    finally:
        if not valid_author:
            print('Books could not be found. Please try again.')

# The library holds books with ID from 1-43.
# The below function is used in validating the ID entered by the user within the next function.
# This way any errors caused by incorrect input can be handled.

def book_id_validation(number):
    if number < 0:
        raise ValueError('Book ID must be positive.')

    assert 1 <= number <= 43, 'We currently hold books 1-43 only.'

    return True

# This first function allows a user to return a book, using the URL from the /borrowing endpoint with DELETE method.
# The book validation function above is used, raising the exceptions for invalid input.
# Only if no exceptions occur is the input accepted as a valid book and the API interaction goes ahead.

def remove_old_borrow():
    try:
        idno = int(input('Please enter the number for the book you wish to return: '))
        book_id_validation(idno)

    except ValueError:
        print('Invalid input: ID must be a positive integer.')

    except AssertionError:
        print(f'Must enter a book ID within range 1-43.')

    else:
        # This dictionary passes the value idno entered by the user, via the API to the b_id parameter within the
        # old_borrow function in db_utils, by using the key of the same name. The API passes back the response from
        # the db_utils interaction with the DB.
        returning = {'b_id': idno}
        response = requests.delete(f'http://127.0.0.1:5000/borrowing', json=returning)
        print(response.json())

# This second function allows a user to borrow a book, using the URL from the /borrowing endpoint with POST method.
# The book validation function above is used, raising the exceptions for invalid input.
# Only if no exceptions occur is the input accepted as a valid book and the API interaction goes ahead.

def add_new_borrow():
    try:
        number = int(input('Please enter the number for the book you wish to borrow: '))
        book_id_validation(number)

    except ValueError:
        print('Invalid input: ID must be a positive integer.')

    except AssertionError:
        print(f'Must enter a book ID within range 1-43.')

    else:
        name = input('Please enter your full name: ')

        # This dictionary passes the values number and name entered by the user, via the API to the chosen_book and
        # reader parameters in the new_borrow function in db_utils, by using keys with the same names. The API passes
        # back the response from the db_utils interaction with the DB.
        borrows = {
             "chosen_book": number,
             "reader": name
        }

        result = requests.post(
            'http://127.0.0.1:5000/borrowing',
            headers={'content-type': 'application/json'},
            json = borrows
        )

        return print(result.json())

# This run function simulates the full user interaction with the API.
# Book numbers 8, 4 and 24 have already been borrowed, so you can choose from these to demo returning a
# book or to see the script handling a user request to borrow a book which is already on loan.

def run():
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print('Welcome to the Poetry Library')
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print()
    books_back = input('Do you have any books to return? (y/n): ').lower()
    if books_back == 'y':
        remove_old_borrow()
    else:
        pass
    print()
    print('Here are the authors we hold.')
    display_authors()
    print()
    get_books_by_author()
    print()
    add_new_borrow()
    print()
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print('Poetry Library - CLOSED')
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~')


if __name__ == '__main__':
    run()
