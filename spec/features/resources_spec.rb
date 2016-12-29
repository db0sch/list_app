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
    expect(page).to have_text(resource2.title)
    expect(page).to have_text(resource2.content)
    expect(page).to have_text(resource2.uri)
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
    # visitor not logged in
    user = create(:user)
    collection = create(:collection, user: user)
    resource = create(:resource, collection: collection)
    # can access and view a collection
    visit "/collections/#{collection.id}/resources/#{resource.id}"
    edit_link = "#edit-resource-#{resource.id}"
    delete_link = "#delete-resource-#{resource.id}"
    expect(page.has_no_link?(edit_link)).to be true
    expect(page.has_no_link?(delete_link)).to be true
  end

  scenario "A user can see a resource (if collection is public or open" do
    user = create(:user)
    login_as(user, :scope => :user)
    collection = create(:collection)
    resource = create(:resource, collection: collection)
    visit "/collections/#{collection.id}/resources/#{resource.id}"
    expect(page).to have_text(resource.title)
    expect(page).to have_text(resource.content)
    expect(page).to have_text(resource.uri)
    # same specs for collection with status: :is_open
    collection2 = create(:collection, user: user, status: :is_open)
    resource2 = create(:resource, collection: collection2)
    visit "/collections/#{collection2.id}/resources/#{resource2.id}"
    expect(page).to have_text(resource2.title)
    expect(page).to have_text(resource2.content)
    expect(page).to have_text(resource2.uri)
  end

  scenario "A user can see a resource even if from private collection" do
    user = create(:user)
    login_as(user, :scope => :user)
    collection = create(:collection, status: :is_private)
    resource = create(:resource, collection: collection)
    visit "/collections/#{collection.id}/resources/#{resource.id}"
    expect(page).to have_text(resource.title)
    expect(page).to have_text(resource.content)
    expect(page).to have_text(resource.uri)
  end

  scenario "A user can interact with a resource (edit, comment) if he is the author of the collection", js: true do
    user = create(:user)
    login_as(user, :scope => :user)
    collection = create(:collection, user: user)
    resource = create(:resource, collection: collection)
    visit "/collections/#{collection.id}/resources/#{resource.id}"
    # add a comment
    comment = 'Lorem ipsium Lorem ipsium Lorem ipsium Lorem ipsium'
    fill_in 'Content', with: comment
    click_on "add a comment"
    expect(page).to have_text(comment)
    # edit
    new_title = "This is a new title"
    new_content = "This is the new content"
    new_url = "www.newurl.com"
    click_link "edit-resource-#{resource.id}"
    fill_in "Title", with: new_title
    fill_in "Content", with: new_content
    fill_in "Uri", with: new_url
    click_on "add a resource"

    visit "/collections/#{collection.id}/resources/#{resource.id}"
    expect(page).to have_text(new_title)
    expect(page).to have_text(new_content)
    expect(page).to have_text(new_url)
  end

  scenario "A user can upvote a resource", js: true do
    user = create(:user)
    login_as(user, :scope => :user)
    collection = create(:collection, user: user)
    resource = create(:resource, collection: collection)
    visit "/collections/#{collection.id}/resources/#{resource.id}"
    upvote_before = find("#resource-#{resource.id}-upvotes").text.to_i
    click_on "upvote-btn-resource-#{resource.id}"
    sleep 1
    upvote_after = find("#resource-#{resource.id}-upvotes").text.to_i
    expect(upvote_after).to be > upvote_before
    vote = user.liked? resource
    expect(vote).to be true
  end

end
