require 'spec_helper'

RSpec.describe BookManager do
  context 'without books' do
    subject(:manager) { BookManager.new }

    describe '.get_book_count' do
      let(:expected_number) { 0 }

      it 'returns 0' do
        expect(manager.get_book_count).to eq(expected_number)
      end
    end

    describe '.add_book' do
      let(:book) { Book.new 1, 'John Doe', 'Red Book', 2000 }
      let(:expected_number) { 1 }

      it 'adds new book to the storage' do
        manager.add_book(book)
        expect(manager.get_book_count).to eq(expected_number)
        expect(manager.get_book(book.id)).to eq(book)
      end
    end
  end

  context 'with some books' do
    let(:books) { [
      (Book.new 1, 'John Doe', 'Red Book', 2000),
      (Book.new 2, 'John Doe', 'Green Book', 2001),
      (Book.new 3, 'John Doe', 'Blue Book', 2002)
    ] }
    subject(:manager) { BookManager.new books }

    describe '.get_book_count' do
      let(:expected_number) { 3 }

      it 'returns correct number of books' do
        expect(manager.get_book_count).to eq(expected_number)
      end
    end

    describe '.remove_book' do
      let(:expected_number) { 2 }
      let(:id) { 1 }

      it 'removes certain book' do
        expect(manager).to receive(:get_book).and_return(books[0])
        manager.remove_book(id)
        expect(manager.get_book_count).to eq(expected_number)
      end
    end
  end
end