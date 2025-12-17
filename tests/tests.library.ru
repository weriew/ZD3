from src.library import Book, User


def test_user_can_borrow_book_and_book_becomes_unavailable():
    book = Book("Тест", "Автор", 2024, available=True)
    user = User("Илья")

    user.borrow(book)

    assert book.is_available() is False
    assert book in user.get_borrowed_books()


def test_user_can_return_book_and_book_becomes_available_again():
    book = Book("Тест", "Автор", 2024, available=True)
    user = User("Илья")

    user.borrow(book)
    user.return_book(book)

    assert book.is_available() is True
    assert book not in user.get_borrowed_books()
