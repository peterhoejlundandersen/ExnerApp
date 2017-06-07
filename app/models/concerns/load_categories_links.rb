module LoadCategoriesLinks
	extend ActiveSupport::Concern

	included do 
		before_action :nav_links
	end

	def nav_links
		@categories = Category.sort_by_position
	end

end
