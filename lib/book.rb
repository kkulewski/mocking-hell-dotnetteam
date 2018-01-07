class Book
  attr_accessor :id, :author, :title, :year, :rented_by

  def initialize(id, author, title, year)
    @id = id
    @author = author
    @title = title
    @year = year
    @rented_by = nil # user_id
  end

  def validate
    raise ArgumentError, 'Invalid ID' unless valid_id?
    raise ArgumentError, 'Invalid year' unless valid_year?
  end

  def valid_id?
    @id.is_a?(Numeric)
  end

  def valid_year?
    @year <= Data.today.year
  end
end
