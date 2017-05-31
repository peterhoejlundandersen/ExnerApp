module CurrentUserConcern

	extend ActiveSupport::Concern

	# Overwrite devise current_user method
	def current_user
		super || guest_user
	end


	def guest_user
		OpenStruct.new(email: "test@test.com")
	end


end