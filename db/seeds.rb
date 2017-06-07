# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


@category = Category.create!(name: "Kirker og sognegårde", position: 1)
@category = Category.create!(name: "Koldinghus", position: 2)
@category = Category.create!(name: "Særlige bygninger", position: 3)
@category = Category.create!(name: "Andre", position: 4)
@category = Category.create!(name: "Kirkerestaureringer", position: 5)
@category = Category.create!(name: "Design", position: 6)
@category = Category.create!(name: "Ikke opført", position: 7)



10.times do |num|
	Work.create!(sagsnr: 123 + num, name: "Heeeey", category_id: Category.first.id)
end


