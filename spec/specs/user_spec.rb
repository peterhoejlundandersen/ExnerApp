require 'rails_helper'
require 'modules/user_actions'

RSpec.describe "UserAction" do
  let(:user) {create(:user)}
  it "should not be possible to log in without confirmation" do
    log_in user
    expect(page).to eq(new_user_session_path())
  end
  it "should not be possible to edit, delete, create work or categories if you're not logged in" do


  end


end
