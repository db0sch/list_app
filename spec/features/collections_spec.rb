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

  scenario "user can delete a collection", js: true do
    user = create(:user)
    login_as(user, :scope => :user)

    collection = create(:collection, user: user)

    id = collection.id

    visit "/collections/#{collection.id}"

    expect(page).to have_text("delete this collection")
    accept_alert do
      click_link "delete this collection"
    end
    expect(page).to_not have_text(collection.title)
  end
end
