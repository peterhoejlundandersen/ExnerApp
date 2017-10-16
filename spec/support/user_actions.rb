module UserActions

  def log_user_in
    visit new_user_session_path()
    within("form") do
      print page
    end
  end

end
