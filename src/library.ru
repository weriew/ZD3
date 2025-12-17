class Book:
    def __init__(self, title, author, year, available=True):
        self.__title = title
        self.__author = author
        self.__year = year
        self.__available = available

    def get_title(self):
        return self.__title

    def get_author(self):
        return self.__author

    def get_year(self):
        return self.__year

    def is_available(self):
        return self.__available

    def mark_as_taken(self):
        self.__available = False

    def mark_as_returned(self):
        self.__available = True

    def __str__(self):
        return f"{self.__title}, {self.__author}, {self.__year}"


class PrintedBook(Book):
    def __init__(self, title, author, year, pages, condition):
        super().__init__(title, author, year)
        self.pages = pages
        self.condition = condition

    def repair(self):
        if self.condition == "плохая":
            self.condition = "хорошая"


class EBook(Book):
    def __init__(self, title, author, year, file_size, file_format):
        super().__init__(title, author, year)
        self.file_size = file_size
        self.file_format = file_format

    def download(self):
        return "Книга загружается..."


class User:
    def __init__(self, name):
        self.name = name
        self.__borrowed_books = []

    def borrow(self, book):
        if book.is_available():
            book.mark_as_taken()
            self.__borrowed_books.append(book)
            print(f"{self.name} взял(а) книгу")
        else:
            print(f"Книга недоступна для взятия.")

    def return_book(self, book):
        if book in self.__borrowed_books:
            self.__borrowed_books.remove(book)
            book.mark_as_returned()
            print(f"{self.name} вернул(а) книгу")
        else:
            print(f"{self.name} не брал(а) книгу")

    def show_books(self):
        if not self.__borrowed_books:
            print(f"{self.name} нет взятых книг.")
        else:
            print(f"Книги у {self.name}:")
            for book in self.__borrowed_books:
                print(book)

    def get_borrowed_books(self):
        return self.__borrowed_books


class Librarian(User):
    pass


class Library:
    def __init__(self):
        self.__books = []
        self.__users = []

    def add_book(self, book):
        self.__books.append(book)

    def remove_book(self, title):
        self.__books = [b for b in self.__books if b.get_title() != title]

    def add_user(self, user):
        self.__users.append(user)

    def find_book(self, title):
        for b in self.__books:
            if b.get_title() == title:
                return b
        return None

    def find_user(self, name):
        for u in self.__users:
            if u.name == name:
                return u
        return None

    def show_all_books(self):
        print(self.__books)

    def show_available_books(self):
        print("Доступные книги:")
        for b in self.__books:
            if b.is_available():
                print(b)

    def lend_book(self, title, user_name):
        book = self.find_book(title)
        user = self.find_user(user_name)
        if book and user:
            user.borrow(book)

    def return_book(self, title, user_name):
        book = self.find_book(title)
        user = self.find_user(user_name)
        if book and user:
            user.return_book(book)
