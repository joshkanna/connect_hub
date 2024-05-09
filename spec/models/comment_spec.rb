# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'when creating a new comment' do
    let(:comment) { build :comment }
    let(:comment2) { build :comment, body: nil }

    describe 'Associations' do
      it { should belong_to(:user).without_validating_presence }
      it { should belong_to(:post).without_validating_presence }
    end

    describe 'Validations' do
      it 'is valid with valid attributes' do
        expect(comment).to be_valid
      end

      it 'is not valid with no body' do
        expect(comment2).to_not be_valid
      end
    end
  end
end
