class User
  attr_accessor :id, :first_name, :last_name, :pesel, :overall_rented_books, :currently_rented_books

  def initialize(id, first_name, last_name, pesel, currently_rented_books = [])
    @id = id
    @first_name = first_name
    @last_name = last_name
    @pesel = pesel
    @overall_rented_books = 0
    @currently_rented_books = currently_rented_books
    validate
  end

  def to_s
    "[#{id}]: #{first_name} #{last_name} - #{pesel}"
  end

  def validate
    raise ArgumentError, 'Invalid ID' unless valid_id?
    raise ArgumentError, 'Invalid PESEL' unless valid_pesel?
    raise ArgumentError, 'Invalid first name' unless valid_first_name?
    raise ArgumentError, 'Invalid last name' unless valid_last_name?
  end

  def valid_id?
    @id.is_a?(Numeric)
  end

  def valid_first_name?
    @first_name.is_a?(String) && @first_name.chars.first =~ /[A-Z]/ && @first_name.length > 2
  end

  def valid_last_name?
    @last_name.is_a?(String) && @last_name.chars.first =~ /[A-Z]/ && @first_name.length > 2
  end

  def valid_pesel?
    @pesel =~ /^[0-9]{11}$/
  end
end
