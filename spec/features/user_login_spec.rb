require 'rails_helper'

RSpec.feature "Loggin in" do
  include UserHelpers
  let(:user) {create(:user)}

  scenario "shouldn't be possible to login without a password" do
    user.password = ""
    log_user_in user
    expect(current_path).to eq(new_session_path())
  end

end
