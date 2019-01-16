require 'rails_helper'

RSpec.describe "users/show", type: :view do
  describe "users/show" do
    let(:user_one) { FactoryBot.create(:user, name: "Animal Farm") }

    it "should show users" do
      assign(:user, user_one)
      render
      expect(rendered).to match user_one.name
    end
  end
end
