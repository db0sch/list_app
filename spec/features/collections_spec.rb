require 'rails_helper'

RSpec.feature "Collections", type: :feature do
  scenario "user can't create collection if not logged in" do
    visit "/collections/new"
    expect(page).to have_content('You need to sign in or sign up before continuing.')
    expect(page).to_not have_content('Title')
    expect(page).to_not have_content('create a collection')
  end

  scenario "user can create new collection (list)" do
    user = create(:user)
    login_as(user, :scope => :user)

    visit "/collections/new"

    title = "Best news website"
    description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
    tagline = "this is the tagline"
    status = "Open"

    fill_in "Title", with: title
    fill_in "Description", with: description
    fill_in "Tagline", with: tagline
    choose status
    click_button "create a collection"

    expect(page).to have_text(title)
    expect(page).to have_text(description)
    expect(page).to have_text(tagline)
    expect(page).to have_link("add a resource")
    expect(page).to have_text("Comments")
    expect(page).to have_text(status)
  end

  scenario "user can edit a collection" do
    user = create(:user)
    login_as(user, :scope => :user)

    collection = create(:collection, user: user)

    # visit "/collections/#{collection.id}/edit"
    visit "/collections/#{collection.id}"

    click_link "edit collection"

    title = "New title for testing, hey"
    description = "Hello, I love you, can you tell me your name?"
    tagline = "another tagline"
    status = "Private"

    fill_in "Title", with: title
    fill_in "Description", with: description
    fill_in "Tagline", with: tagline
    choose status
    click_button "create a collection"

    expect(page).to have_text(title)
    expect(page).to have_text(description)
    expect(page).to have_text(tagline)
    expect(page).to have_link("add a resource")
    expect(page).to have_text("Comments")
    expect(page).to have_text(status)
  end

  scenario "user can delete a collection (if he is the author)", js: true do
    user = create(:user)
    login_as(user, :scope => :user)

    collection = create(:collection, user: user)

    visit "/collections/#{collection.id}"

    expect(page).to have_text("delete this collection")
    accept_alert do
      click_link "delete this collection"
    end
    expect(page).to_not have_text(collection.title)
  end

  scenario "user cannot delete a collection (if he is not the author)", js: true do
    user = create(:user)
    login_as(user, :scope => :user)

    collection = create(:collection)

    visit "/collections/#{collection.id}"

    # should not be able to edit or delete a collection that the user has not created.
    # should not be able to even see the buttons for delete and edit
  end

  scenario "a visitor (non-logged in) can see a collection if it's public or open" do
    # visitor not logged in
    # can access and view a collection
    # but can't edit it or delete it
  end

  scenario "a visitor (non-logged in) can't see a collection if it's private" do
    # user not logged in
    # can't access or view a collection if status: is_private
    # should say you're not allowed
  end

  scenario "a user (logged in) can see a collection if it's public or open" do
    # user logged in
    # can access and view a collection
    # but can't edit it or delete it
  end

  scenario "a user (logged in) can interact with a collection if it's public" do
    # user logged in
    # can access and view a collection
    # can upvote resources
    # post comments
  end

  scenario "a user (logged in) can interact with a collection if it's open" do
    # user logged in
    # can access and view a collection
    # can upvote resources
    # post comments
    # add a new resource to the collection
  end

  scenario "a user (logged in) can star a collection (open or public)" do
    # user logged in
    # can access and view a collection
    # can upvote resources
    # post comments
    # add a new resource to the collection
  end

  scenario "a user (logged in) can follow a collection (open or public)" do
    # user logged in
    # can access and view a collection
    # can upvote resources
    # post comments
    # add a new resource to the collection
  end

end