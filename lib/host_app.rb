require_relative 'console_io'
require_relative 'user'
require_relative 'user_manager'
require_relative 'book'
require_relative 'book_manager'
require 'date'

class HostApp
  def initialize(io)
    @io = io
    @user_manager = UserManager.new
    @book_manager = BookManager.new
  end

  def write(message)
    @io.write ">> #{message}"
  end

  def read
    @io.read
  end

  def run
    loop do
      print_gap
      print_main_menu
      choose_main_option
    end
  end

  def print_gap
    @io.write ''
    @io.write ''
  end

  def status(result)
    result.nil? ? 'ERROR' : 'OK'
  end

  ### MAIN

  def print_main_menu
    write '-- MAIN MENU --'
    write '[1] USER MANAGEMENT'
    write '[2] BOOK MANAGEMENT'
  end

  def choose_main_option
    option = read
    print_gap
    case option
    when '1'
      print_user_menu
      choose_user_option
    when '2'
      print_book_menu
      choose_book_option
    else
      write 'Wrong option!'
    end
  end

  ### USER MANAGEMENT

  def print_user_menu
    write '-- USER MENU --'
    write '[1] LIST USERS'
    write '[2] ADD USER'
    write '[3] REMOVE USER'
    write '[4] UPDATE USER'
  end

  def choose_user_option
    option = read
    print_gap
    case option
    when '1'
      print_users
    when '2'
      add_user
    when '3'
      remove_user
    when '4'
      update_user
    else
      write 'Wrong option!'
    end
  end

  def print_users
    write '-- USERS --'
    @user_manager.users.each { |x| write x.to_s }
  end

  def add_user
    write '-- ADD NEW USER --'
    user = create_user
    result = @user_manager.add_user user
    write status(result)
  end

  def create_user
    write 'ID?'
    id = Integer(read)
    write 'First name?'
    first_name = read
    write 'Last name?'
    last_name = read
    write 'PESEL?'
    pesel = read
    User.new id, first_name, last_name, pesel
  end

  def remove_user
    write '-- REMOVE USER --'
    write 'ID?'
    user_id = Integer(read)
    result = @user_manager.remove_user user_id
    write status(result)
  end

  def update_user
    write '-- UPDATE USER --'
    write 'ID?'
    user_id = Integer(read)
    updated_user = create_user
    result = @user_manager.update_user(user_id, updated_user)
    write status(result)
  end

  ### BOOK MANAGEMENT

  def print_book_menu
    write '-- BOOK MENU --'
    write '[1] LIST BOOKS'
    write '[2] ADD BOOK'
    write '[3] REMOVE BOOK'
    write '[4] UPDATE BOOK'
  end

  def choose_book_option
    option = read
    print_gap
    case option
    when '1'
      print_books
    when '2'
      add_book
    when '3'
      remove_book
    when '4'
      update_book
    else
      write 'Wrong option!'
    end
  end

  def print_books
    write '-- BOOKS --'
    @book_manager.books.each { |x| write x.to_s }
  end

  def add_book
    write '-- ADD NEW BOOK --'
    book = create_book
    result = @book_manager.add_book book
    write status(result)
  end

  def create_book
    write 'ID?'
    id = Integer(read)
    write 'Author?'
    author = read
    write 'Title?'
    title = read
    write 'Year?'
    year = Integer(read)
    Book.new id, author, title, year
  end

  def remove_book
    write '-- REMOVE BOOK --'
    write 'ID?'
    book_id = Integer(read)
    result = @book_manager.remove_book book_id
    write status(result)
  end

  def update_book
    write '-- UPDATE BOOK --'
    write 'ID?'
    book_id = Integer(read)
    updated_book = create_book
    result = @book_manager.update_book(book_id, updated_book)
    write status(result)
  end

  ### HELPERS

  def populate
    @user_manager.add_user(User.new(1, 'John', 'Doe', '91010155666'))
    @user_manager.add_user(User.new(2, 'Kate', 'Smith', '75101198765'))
    @user_manager.add_user(User.new(3, 'Tom', 'Parker', '85051045678'))
    @user_manager.add_user(User.new(4, 'Edgar', 'Williams', '60110122333'))
    @user_manager.add_user(User.new(5, 'Jen', 'Brown', '95030400111'))
  end
end
