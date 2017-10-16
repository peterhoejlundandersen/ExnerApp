module UserActions

def log_in user, with_confirmation=true
  visit new_user_session_path()
  if with_confirmation
    user.confirmed_at = Time.now
    user.save!
  end
  within("form") do
    fill_in "user[email]", user.email
    fill_in "user[name]", user.name
  end
end


end
