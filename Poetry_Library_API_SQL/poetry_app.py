# This is the file that runs the flask web API.
# Flask is a framework in Python for building web apps & APIs.
from flask import Flask, jsonify, request
# jsonify converts Python data structures like dictionaries into JSON format.
# request gives access to incoming HTTP requests in the Flask routes.

# The functions in db_utils are imported to be used here at their appropriate endpoints.
from poetry_db_utils import get_all_authors, get_author_books, new_borrow, old_borrow

app = Flask(__name__) # This creates the Flask app instance

# Welcome message which establishes API working at base URL.

@app.route('/')
def welcome():
    return 'The Poetry Library is open!'

# http://127.0.0.1:5000 Follow this to find the welcome message in your browser.

# Authors endpoint displays all the authors held at the library.
# The get_all_authors function from db_utils is used here.

@app.route('/authors')
def find_authors():
    result = get_all_authors()
    return jsonify(result)

# http://127.0.0.1:5000/authors Follow this in your browser to find all the authors held by the library.

# Books endpoint, using id to see books by a given author.
# The get_author_books function from db_utils is used here.

@app.route('/books/<int:id>')
def find_books(id):
    auth_books = get_author_books(id)
    return jsonify(auth_books)

# http://127.0.0.1:5000/books/3 All books by Seamus Heaney

# Borrowing endpoint with DELETE method, so that returned books become available again.
# The old_borrow function from db_utils is used here.

@app.route('/borrowing', methods=['DELETE'])
def delete_borrow():
    data = request.get_json()
    b_id = data.get('b_id')

    returned_book = old_borrow(b_id)
    return jsonify(returned_book)


# Borrowing endpoint with POST method, so that the name and dates of a newly borrowed book can be recorded.
# The new_borrow function from db_utils is used here.

@app.route('/borrowing', methods=['POST'])
def borrow_book():
    table = request.get_json()
    b_id = table.get('chosen_book')
    reader_name = table.get('reader')

    if not b_id:
        return jsonify({'Borrow update': 'Book not recorded as on loan. Please check ID.'})

    result = new_borrow(b_id, reader_name)
    return result


if __name__ == '__main__': # Ensures only runs when called directly, not when imported
    app.run(debug=True) # Enables debug mode
