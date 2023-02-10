# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
products = [
  {
    name: 'Product 1',
    category: 'Cat1',
    reference: 'Ref1',
    price: 100
  },
   {
    name: 'Product 2',
    category: 'Cat2',
    reference: 'Ref2',
    price: 100
  }
]

products.each { |product| Product.create(product) }

destinations = [
  {
    name: 'D1',
    categories: ['Cat1'],
    references: []
  },
  {
    name: 'D2',
    categories: [],
    references: ['Ref1']
  },
  {
    name: 'D3',
    categories: ['Cat1'],
    references: ['Ref1']
  },
  {
    name: 'D4',
    categories: ['Cat2'],
    references: []
  },
]

destinations.each { |product| Destination.create(product) }