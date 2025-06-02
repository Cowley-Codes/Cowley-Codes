# This file contains all the code which interacts directly with the DB in MySQL.
# Functions are imported from here into app.py, for use where applicable with the API.

# This is necessary to establish the connection to MySQL
import mysql.connector
# You MUST update the HOST, USER and PASSWORD to your own details in config.py, for this to work.
from config import HOST, USER, PASSWORD
# These modules are used to write today's date and the date in three weeks' time in the new_borrow() function.
from datetime import datetime, timedelta


# Establishing db connection with mysql.connector, using details imported from config
# Exception for when the connection to the database fails

class DbConnectionError(Exception):
    pass

def _connect_to_db(db_name):
    cnx = mysql.connector.connect(
        host = HOST,
        user = USER,
        password = PASSWORD,
        auth_plugin = 'mysql_native_password',
        database = db_name
    )
    return cnx

# Querying the DB to get all authors, this is then used at the /authors endpoint in app.py.

def get_all_authors():
    try:
        # These first four lines establish the connection to the Poetry_Library DB.
        # They are therefore the same in each of the functions.
        db_name = 'Poetry_Library'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print('Connected to DB: %s' %db_name)

        query = 'SELECT a_id, auth_name, auth_surname FROM Authors' # Query to retrieve all author info.
        cur.execute(query) # The cursor executes the above query in MySQL.

        result = cur.fetchall() # fetchall() used as there are multiple authors.
        cur.close() # The cursor is closed once the query is executed and results fetched.

    except Exception: # This raises the exception defined above for failing to connect to the DB in MySQL.
        raise DbConnectionError('Failed to read data from DB.')

    finally:
            if db_connection: # Should the connection have been successful, we now close it.
                db_connection.close()
                print('DB connection closed.')

    return result # The result is the author information fetched from the DB.



# Querying the db for books by a given author, this is then used at the /books endpoint.
# There is an additional parameter of the author id.
# This is used in the query and at the endpoint to find info on books by the specified author.

def get_author_books(a_id):
    try:
        db_name = 'Poetry_Library'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print('Connected to DB: %s' %db_name)

        # This query retrieves all books by a given author. ''' used as more complex query over multiple line.
        query = ''' 
                SELECT b.b_id, b.title, b.availability
                FROM books_availability AS b
                WHERE b.a_id = %s
                '''

        cur.execute(query, (a_id,))
        # .execute() expects the second argument to a list/tuple.
        # So the trailing comma is included so that the a_id is recognised as part of the parameter tuple
        # even though there is only one value in the tuple.
        # This way the %s placeholder in the query is filled by the parameters in a safe way.

        result = cur.fetchall() # Again there are multiple results to fetch.
        cur.close()

    except Exception:
        raise DbConnectionError('Failed to read data from DB.')

    finally:
            if db_connection:
                db_connection.close()
                print('DB connection closed.')

    return result # The result is the book information by the specified author, fetched from the DB.


# Querying the DB to delete the corresponding row from the Borrowing table when a book is returned.
# This is then used in the Borrowing endpoint with DELETE method in app.py
# There is an additional parameter of the book ID so that the correct row is deleted.

def old_borrow(b_id):
    try:
        db_name = 'Poetry_Library'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print('Connected to DB: %s' %db_name)


        # This first query finds the return date for the specified book from its row in the Borrowing table.
        check_query = 'SELECT return_date FROM Borrowing WHERE b_id=%s'
        cur.execute(check_query, (b_id,))
        on_loan = cur.fetchone() # There is only one result to fetch this time, since the row is deleted when a book is returned.

        if not on_loan: # If there is no result, the book has not been recorded as borrowed so can not be returned.
            cur.close()
            return {'Return update': 'Book not recorded as out on loan. Please check ID.'}

        else: # If the check query is successful then the corresponding row is then deleted, making the book available again.
            delete_query = ''' DELETE 
                    FROM Borrowing AS b
                    WHERE b.b_id = %s
                    '''
            cur.execute(delete_query, (b_id,))
            db_connection.commit() # commits the deletion to the DB
            cur.close()

    except Exception:
        raise DbConnectionError('Failed to read data from DB.')

    finally:
            if db_connection:
                db_connection.close()
                print('DB connection closed.')

    return {'Borrow update': 'Record deleted, successful return.'}



# Querying the DB to insert a new row in the Borrowing table.
# This is then used at the /borrowing endpoint with POST method in app.py.
# There is an additional parameter of the book ID so that the correct book is entered as being borrowed.
# There is an additional parameter of the reader to record the borrower's name in the Borrowing table in the DB.

def new_borrow(chosen_book, reader):
    try:
        db_name = 'Poetry_Library'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print('Connected to DB: %s' % db_name)

        # The same check query is used to find the return date for the specified book from its row in the Borrowing table.
        check_query = 'SELECT return_date FROM Borrowing WHERE b_id=%s'
        cur.execute(check_query, (chosen_book,))
        on_loan = cur.fetchone()

        if on_loan: # If the check query returns a date, the books is already on loan and can't be borrowed until then.
            cur.close()
            # This message is returned giving the next available date.
            return {'Borrow update': f'Already on loan, please try again on {on_loan[0]}'}

        else: # If the check query returns no date, the book can be borrowed.
            # Therefore another query is used to insert a row with this book ID into the Borrowing table.
            # The borrow_date is today and the return_date in three weeks' time.
            insert_query = """
            INSERT INTO Borrowing (b_id, borrow_date, return_date, reader_name)
            VALUES (%s, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 3 WEEK), %s)
            """

            cur.execute(insert_query, (chosen_book, reader))
            db_connection.commit() # This commits the insert
            cur.close()

            # This message is returned giving the success report and required return date.
            bring_back = datetime.today().date() + timedelta(weeks =3)
            return {'Borrow update': f'Successfully borrowed. Please return your book on {bring_back}'}

    except Exception:
        raise DbConnectionError('Failed to read data from DB.')

    finally:

        if db_connection:
            db_connection.close()
            print('DB connection closed.')