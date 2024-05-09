# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating a user' do
    let(:user) { build :user }
    let(:user1) { build :user, username: nil }
    let(:user2) { build :user, email: nil }
    let(:user3) { build :user, password_digest: nil }

    it 'should be valid user with all attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without username' do
      expect(user1).to_not be_valid
    end

    it 'is not valid without email' do
      expect(user2).to_not be_valid
    end

    it 'is not valid without password' do
      expect(user3).to_not be_valid
    end
  end
end
