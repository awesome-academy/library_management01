require 'rails_helper'
require 'spec_helper'

RSpec.describe "users/index", type: :view do
  it "displays all the users" do
    assign(:users, [
      FactoryBot.create(:user, name: "slicer"),
      FactoryBot.create(:user, name: "dicer")
    ])

    assign(:q, Ransack::Search.new(User))

    render
    expect(rendered).to render_template("users/index")
    expect(rendered).to render_template("users/_user")
  end
end
