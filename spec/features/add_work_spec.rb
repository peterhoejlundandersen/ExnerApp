require 'rails_helper'

RSpec.feature "Adding Work" do
  let(:user) {create(:user)}
  scenario "should not be able to visit new_work not logged in" do
    visit new_work_path()
    expect(current_path).to eq(user_session_path())
  end

  scenario "should not be able to create work without title" do
    visit user_session_path()
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
  end
end
