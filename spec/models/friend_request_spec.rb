require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe "Associations" do 
    it { should belong_to(:sender) }
    it { should belong_to(:receiver) }
  end

  describe "Validations" do
    let(:sender)  { User.new(:username => "jjkanna", :email => "j@g.com", :password_digest => "h") } 
    let(:receiver) { User.new(:username => "jericantony", :email => "h@g.com", :password_digest => "k" )}
    
    it "valid with valid attributes" do
      described_class.new(sender_id: sender.id, receiver_id: receiver.id)
    end
  end
  
end
