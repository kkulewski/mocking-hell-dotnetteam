require_relative 'console_io'
require_relative 'user'
require_relative 'user_manager'
require_relative 'book'
require_relative 'book_manager'

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
end
