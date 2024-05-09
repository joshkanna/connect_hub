# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'when creating a post' do
    describe 'Associations' do
      let(:post) { build :post }
      let(:post1) { build :post, title: nil }
      let(:post2) { build :post, body: nil }

      it { should belong_to(:user).without_validating_presence }
    end

    describe 'Validations' do
      it 'is valid with valid attributes' do
        expect(post).to be_valid
      end

      it 'is not valid without a title' do
        expect(post1).to_not be_valid
      end

      it 'is not valid without a body' do
        expect(post2).to_not be_valid
      end
    end
  end
end
