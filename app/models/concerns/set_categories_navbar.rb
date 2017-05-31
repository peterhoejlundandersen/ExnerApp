module SetCategoriesNavbar

	extend ActiveSupport::Concern

	included do 
		before_action :set_categories
	end

	def set_categories
		@categories = Category.all
	end

end