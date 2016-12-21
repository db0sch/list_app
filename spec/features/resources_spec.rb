require 'rails_helper'

RSpec.feature "Resources", type: :feature do

  scenario "A visitor can see a resource (if collection is public or open)" do
    # TODO
  end

  scenario "A visitor cannot see a resource if collection is private" do
    # TODO
  end

  scenario "A visitor cannot interact with the resource (comment, edit or delete)" do
    # TODO
  end

  scenario "A user can see a resource (if collection is public or open" do
    # TODO
  end

  scenario "A user cannot see a resource if collection is private" do
    # TODO
  end

  scenario "A user can see a resource from a private collection if he is the author" do
    # TODO
  end

  scenario "A user can interact with a resource (edit, comment) if he is the author of the collection" do
    # TODO
  end

  scenario "A user can add a resource if the collection is open" do
    # TODO
  end

  scenario "A user cannot edit or delete a resource event if the collection is open" do
    # TODO
  end

  scenario "A user can upvote a resource" do

  end

end
