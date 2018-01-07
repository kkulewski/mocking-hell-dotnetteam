class Book
  attr_accessor :id, :author, :title, :year, :rented_by

  def initialize(id, author, title, year)
    @id = id
    @author = author
    @title = title
    @year = year
    @rented_by = nil
    validate
  end

  def validate
    raise ArgumentError, 'Invalid ID' unless valid_id?
    raise ArgumentError, 'Invalid author' unless valid_author?
    raise ArgumentError, 'Invalid title' unless valid_title?
    raise ArgumentError, 'Invalid year' unless valid_year?
  end

  def valid_id?
    @id.is_a?(Numeric)
  end

  def valid_author?
    @author.is_a?(String) && @author.length >= 1 && @author.length <= 50 && @author.chars.first =~ /[A-Z]/
  end

  def valid_title?
    @title.length >= 1 && @title.length <= 100
  end

  def valid_year?
    @year <= Date.today.year
  end
end
