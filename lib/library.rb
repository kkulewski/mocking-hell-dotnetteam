class Library
  def initialize(user_manager, book_manager)
    @user_manager = user_manager
    @book_manager = book_manager
  end

  def rent_book(user_id, book_id)
    user = @user_manager.get_user(user_id)
    book = @book_manager.get_book(book_id)

    book.rented_by = user.id
    @user_manager.add_book(user.id, book)
  end

  def return_book(user_id, book_id)
    user = @user_manager.get_user(user_id)
    book = @book_manager.get_book(book_id)

    book.rented_by = nil
    @user_manager.remove_book(user.id, book)
  end

  def best_readers
    @user_manager.users.sort_by(&:overall_rented_books).reverse
  end

  def total_books_rented
    @user_manager.users.sum(&:overall_rented_books)
  end

  def average_books_rented
    total_books_rented.to_f / @user_manager.users.count
  end
end
