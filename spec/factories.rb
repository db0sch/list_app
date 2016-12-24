require 'faker'

FactoryGirl.define do

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.user_name("#{first_name} #{last_name}", %w(. _ -)) }
    email { Faker::Internet.safe_email("#{first_name}_#{last_name}") }
    password Faker::Internet.password
    bio Faker::Lorem.sentence
  end

  factory :collection do
    user
    title { Faker::Book.title }
    tagline { Faker::Lorem.sentence }
    description Faker::Hipster.paragraph
    status { [:is_public, :is_public, :is_public, :is_open, :is_private].sample }
  end

  factory :resource do
    collection
    title { Faker::App.name }
    content { Faker::Lorem.paragraph }
    uri { Faker::Internet.url }
  end

  factory :comment do
    commentable factory: :resource
    user
    content { Faker::Lorem.paragraph }
  end

  factory :follow do
    user
    collection
  end

end
