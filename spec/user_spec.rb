require 'spec_helper'

RSpec.describe User do
  describe '.new' do
    subject(:valid_user) { User.new 1, 'John', 'Doe', '90010198765' }
    subject(:user_with_wrong_id) { User.new 'A', 'John', 'Doe', '90010198765' }
    subject(:user_with_wrong_first_name) { User.new 1, 'johan', 'Doe', '90010198765' }
    subject(:user_with_wrong_last_name) { User.new 1, 'Joe', 'dont', '90010198765' }
    subject(:user_with_wrong_pesel) { User.new 1, 'John', 'Doe', '90010198a65' }

    it 'initializes a new valid user' do
      expect { valid_user }.not_to raise_error
    end

    it 'raises error on user with wrong id' do
      expect { user_with_wrong_id }.to raise_error(ArgumentError)
    end

    it 'raises error on user with wrong first name' do
      expect { user_with_wrong_first_name }.to raise_error(ArgumentError)
    end

    it 'raises error on user with wrong last name' do
      expect { user_with_wrong_last_name }.to raise_error(ArgumentError)
    end

    it 'raises error on user with wrong pesel' do
      expect { user_with_wrong_pesel }.to raise_error(ArgumentError)
    end
  end

  describe '.to_s' do
    subject(:user) { User.new 1, 'John', 'Doe', '90010198765' }

    it 'returns formatted first name and last name' do
      expect(user.to_s).to be_a(String).and include('John Doe')
    end
  end
end
