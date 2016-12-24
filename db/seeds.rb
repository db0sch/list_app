# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

10.times do
  user = FactoryGirl.create(:user)
  5.times do
    collection = FactoryGirl.create(:collection, user: user)
    3.times { FactoryGirl.create(:comment, commentable: collection) }
    5.times do
      resource = FactoryGirl.create(:resource, collection: collection)
      5.times { FactoryGirl.create(:comment, commentable: resource) }
    end
  end
end
