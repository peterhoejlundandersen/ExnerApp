# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://ingerogjohannesexner.dk"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #

  add oversigt_path
  add om_path
  add videos_path
  add artikler_path
  add tidslinje_path
  add danmarkskort_path
  add information_om_cookies_path


  Work.find_each do |work|
    add work_path(work.friendly_id)
  end

  Category.where.not(id: [15, 18, 13]).find_each do |cat| # Not design
    add vaerker_path(cat.friendly_id)
  end

  # Design
  Category.where(id: [15, 18, 13]).find_each do |des_cat|
    add vaerker_design_path(des_cat.friendly_id)
  end
end
