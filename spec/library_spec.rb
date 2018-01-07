require 'spec_helper'

RSpec.describe Library do
  context 'with pre-baked book and user' do
    let(:user) { UserFactory.create_single_user_without_books }
    let(:book) { BookFactory.create_single_book }

    let(:book_manager) { instance_double('BookManager') }
    let(:user_manager) { instance_double('UserManager') }

    subject(:library) { Library.new user_manager, book_manager }

    describe '.rent_book' do
      it 'marks book as rented by correct user' do
        allow(user_manager).to receive(:get_user).with(user.id).and_return(user)
        allow(book_manager).to receive(:get_book).with(book.id).and_return(book)
        allow(user_manager).to receive(:add_book).with(user.id, book)

        expect { library.rent_book(user.id, book.id) }.to change { book.rented_by }.from(nil).to(user.id)
      end
    end
  end

  context 'with pre-baked user with a rented book' do
    let(:user) { UserFactory.create_single_user_with_book }
    let(:book) { user.currently_rented_books[0] }

    let(:book_manager) { instance_double('BookManager') }
    let(:user_manager) { instance_double('UserManager') }

    subject(:library) { Library.new user_manager, book_manager }

    describe '.return_book' do
      it 'marks book as not rented' do
        allow(user_manager).to receive(:get_user).with(user.id).and_return(user)
        allow(book_manager).to receive(:get_book).with(book.id).and_return(book)
        allow(user_manager).to receive(:remove_book).with(user.id, book)

        expect { library.return_book(user.id, book.id) }.to change { book.rented_by }.from(user.id).to(nil)
      end
    end
  end

  context 'with pre-baked users with rented books' do
    let(:users) do
      users = UserFactory.create_array_of_users_without_books
      users[0].overall_rented_books = 10
      users[1].overall_rented_books = 5
      users[2].overall_rented_books = 15
      users[3].overall_rented_books = 23
      users
    end
    let(:book_manager) { instance_double('BookManager') }
    let(:user_manager) { instance_double('UserManager') }

    let!(:sorted_users) { [users[3], users[2], users[0], users[1]] }
    let!(:unsorted_users) { [users[0], users[1], users[2], users[3]] }

    subject(:library) { Library.new user_manager, book_manager }

    describe '.best_readers' do
      it 'returns readers sorted by books read' do
        allow(user_manager).to receive(:users).and_return(unsorted_users)
        expect(library.best_readers).to eq(sorted_users)
      end
    end

    describe '.total_books_rented' do
      it 'returns correct amount of books' do
        allow(user_manager).to receive(:users).and_return(unsorted_users)
        sum = unsorted_users.sum(&:overall_rented_books)
        expect(library.total_books_rented).to eq(sum)
      end
    end

    describe '.average_books_rented' do
      it 'returns correct average' do
        allow(user_manager).to receive(:users).and_return(unsorted_users)
        average = unsorted_users.sum(&:overall_rented_books).to_f / unsorted_users.count
        expect(library.average_books_rented).to eq(average)
      end
    end
  end
end
