require "rails_helper"

RSpec.describe User, type: :model do

  context "should have columns" do
    it do
      is_expected.to have_db_column(:name).of_type(:string)
      is_expected.to have_db_column(:role).of_type(:integer)
      is_expected.to have_db_column(:created_at).of_type(:datetime)
      is_expected.to have_db_column(:updated_at).of_type(:datetime)
      is_expected.to have_db_column(:email).of_type(:string)
    end
  end

  context "associations" do
    it do
      is_expected.to have_many(:requests).dependent(:destroy)
      is_expected.to have_many(:user_reviews).dependent(:destroy)
      is_expected.to have_many(:follows).dependent(:destroy)
      is_expected.to have_many(:likes).dependent(:destroy)
      is_expected.to have_many(:liked_books).through(:likes).source(:book)
      is_expected.to have_many(:comments).dependent(:destroy)
    end
  end

  context "validate presence and length" do
    it do
      is_expected.to validate_presence_of :name
      is_expected.to validate_length_of(:name).is_at_most(50).with_message(/is too long/)
      is_expected.to validate_presence_of :email
      is_expected.to validate_length_of(:email).is_at_most(255).with_message(/is too long/)
    end
  end

  context "has valid factory" do
    let(:user) {FactoryBot.build(:user)}
    it {is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity}
    it {expect(user.email).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)}
  end

  context "scopes" do
    let!(:user_one) { FactoryBot.create(:user, name: "Animal Farm") }
    let!(:user_two) { FactoryBot.create(:user, name: "Animal Farm1") }
    it "orders coasters by decrease" do
      expect(User.newest).to eq([user_one, user_two ])
    end
  end
end
