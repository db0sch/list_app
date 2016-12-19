require 'rails_helper'

RSpec.feature "CreateCollections", type: :feature do
  scenario "user can't create collection if not logged in" do

  end

  scenario "user can create new collection (list)" do
    user = create(:user)
    login_as(user, :scope => :user)

    visit "/collections/new"

    collection_title = "Best news website"
    description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit."

    fill_in "Title", with: collection_title
    fill_in "Description", with: description
    click_button "create a collection"
    # fill_in "Resource title", with: resource_title
    # fill_in "Resource content", with: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Provident inventore, ipsum nobis quibusdam asperiores eveniet possimus, ducimus voluptatum, fugiat voluptate reprehenderit. Illo, commodi? Ex tenetur, voluptatum eos a soluta voluptates."
    # fill_in "Resource uri", with: "https://www.bloomberg.com/"
    expect(page).to have_text(collection_title)
    expect(page).to have_text(description)
    expect(page).to have_link("add a resource")
    expect(page).to have_text("Comments")
  end

  scenario "user can edit a collection" do
    user = create(:user)
    login_as(user, :scope => :user)
    p user.id
    collection = create(:collection, user: user)
    p collection
    visit "/collections/#{collection.id}"

    collection_title = "New title for testing, hey"
    description = "Hello, I love you, can you tell me your name?"

    fill_in "Title", with: collection_title
    fill_in "Description", with: description
    click_button "create a collection"
    # fill_in "Resource title", with: resource_title
    # fill_in "Resource content", with: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Provident inventore, ipsum nobis quibusdam asperiores eveniet possimus, ducimus voluptatum, fugiat voluptate reprehenderit. Illo, commodi? Ex tenetur, voluptatum eos a soluta voluptates."
    # fill_in "Resource uri", with: "https://www.bloomberg.com/"
    expect(page).to have_text(collection_title)
    expect(page).to have_text(description)
    expect(page).to have_link("add a resource")
    expect(page).to have_text("Comments")
  end
end
