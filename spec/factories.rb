FactoryGirl.define do
  factory :user do
    name "John Doe"
    email "john.doe@gmail.com"
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
    resource
    user
    content "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
  end

  factory :follow do
    user
    collection
  end

end
