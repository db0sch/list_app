FactoryGirl.define do
  sequence :email do |n|
    "john.doe_#{n}@example.com"
  end

  sequence :name do |n|
    "John Doe #{n}"
  end

  factory :user do
    name
    email
    password "password"
    bio "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
  end

  factory :collection do
    user
    title "My favourite bars"
    tagline "A curated list of all the bars I like in Tokyo"
    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
  end

  factory :resource do
    collection
    title "Le super bar"
    content "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
    uri "www.google.fr"
  end

  factory :comment do
    commentable factory: :resource
    user
    content "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
  end

  factory :follow do
    user
    collection
  end

end
