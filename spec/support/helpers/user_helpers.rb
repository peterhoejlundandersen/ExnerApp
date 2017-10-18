
module UserHelpers

  def log_user_in user, confirmed=true
    if confirmed
      user.confirmed_at = Time.now
      user.save!
    end
    visit new_session_path()
    within("form") do
      fill_in "email", with: user.email
      fill_in "password", with: user.password
    end
  end

end
