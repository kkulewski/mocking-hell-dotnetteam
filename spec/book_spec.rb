require 'spec_helper'

RSpec.describe Book do
  describe '.new' do
    subject(:valid_book) { Book.new 1, 'Donald Knuth', 'The Art of Computer Programming', 1968 }
    subject(:book_with_wrong_id) { Book.new 'A', 'Donald Knuth', 'The Art of Computer Programming', 1968 }
    subject(:book_with_wrong_author) { Book.new 1, '', 'The Art of Computer Programming', 1968 }
    subject(:book_with_wrong_title) { Book.new 1, 'Donald Knuth', '', 1968 }
    subject(:book_with_wrong_year) { Book.new 1, 'Donald Knuth', 'The Art of Computer Programming', 2019 }

    it 'initializes a new book' do
      expect { valid_book }.not_to raise_error
    end

    it 'raises error on user with wrong id' do
      expect { book_with_wrong_id }.to raise_error(ArgumentError)
    end

    it 'raises error on user with wrong author' do
      expect { book_with_wrong_author }.to raise_error(ArgumentError)
    end

    it 'raises error on user with wrong title' do
      expect { book_with_wrong_title }.to raise_error(ArgumentError)
    end

    it 'raises error on book with worng year' do
      expect { book_with_wrong_year }.to raise_error(ArgumentError)
    end
  end

  describe '.to_s' do
    subject(:book) { Book.new 1, 'Donald Knuth', 'The Art of Computer Programming', 1968 }

    it 'returns string with book title' do
      expect(book.to_s).to be_a(String).and include('The Art of Computer Programming')
    end
  end
end
