# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


@category = Category.create!(name: "Koldinghus")
@category = Category.create!(name: "Kirker og Sognegårde")
@category = Category.create!(name: "Kirkerestaureringer")
@category = Category.create!(name: "Offentlige bygninger")
@category = Category.create!(name: "Ikke opført")
@category = Category.create!(name: "Design og orgler")
@category = Category.create!(name: "Andre")
