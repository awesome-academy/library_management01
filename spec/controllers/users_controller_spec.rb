require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user_one) { FactoryBot.create(:user, name: "Animal Farm")}
  let(:user_one) { FactoryBot.create(:user, name: "Animal Farm")}
  describe "#index" do
    before(:each) do
      get :index
    end
    it "responds successfully" do
      expect(response).to be_successful
    end
  end

  describe "GET #show/:id" do
    before(:each) do
      get :show, params: { id: user_one.id }
    end

    it "assigns the requested user to @user" do
      expect(assigns(:user)).to eq(user_one)
    end

    it "should render show user" do
      expect(response).to render_template :show
    end
  end
end
