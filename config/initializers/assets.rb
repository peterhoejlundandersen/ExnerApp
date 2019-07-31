# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add Yarn node_modules folder to the asset load path.
# Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.precompile += %w( works.scss frontpage.scss work_images.js works.js html.sortable.js pdfs font_calls about.scss, pdfs.scss)

# PDF JS ASSETS
Rails.application.config.assets.precompile += %w( angular-pdfjs-viewer/bower_components/pdf.js-viewer/pdf.js angular-pdfjs-viewer/bower_components/pdf.js-viewer/viewer.css angular-pdfjs-viewer/bower_components/angular/angular.js angular-pdfjs-viewer/dist/angular-pdfjs-viewer.js)

Dir.glob("#{Rails.root}/app/assets/images/**/").each do |path| # Subdirectories are added to images assets path
  Rails.application.config.assets.paths << path
end

