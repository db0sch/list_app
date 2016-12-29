require 'rails_helper'

RSpec.feature "Resources", type: :feature do

  scenario "A visitor can see a resource (if collection is public or open)" do
    # visitor not logged in
    user = create(:user)
    collection = create(:collection, user: user)
    resource = create(:resource, collection: collection)
    # can access and view a collection
    visit "/collections/#{collection.id}/resources/#{resource.id}"
    expect(page).to have_text(resource.title)
    expect(page).to have_text(resource.content)
    expect(page).to have_text(resource.uri)
    # same specs for collection with status: :is_open
    # visitor not logged in
    collection2 = create(:collection, user: user, status: :is_open)
    resource2 = create(:resource, collection: collection2)
    # can access and view a collection
    visit "/collections/#{collection2.id}/resources/#{resource2.id}"
    expect(page).to have_text(resource.title)
    expect(page).to have_text(resource.content)
    expect(page).to have_text(resource.uri)
  end

  scenario "A visitor can see a resource if collection is private" do
    # visitor not logged in
    user = create(:user)
    collection = create(:collection, user: user, status: :is_private)
    resource = create(:resource, collection: collection)
    # can access and view a collection
    visit "/collections/#{collection.id}/resources/#{resource.id}"
    expect(page).to have_text(resource.title)
    expect(page).to have_text(resource.content)
    expect(page).to have_text(resource.uri)
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
