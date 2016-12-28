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

  scenario "user cannot delete or edit a collection (if he is not the author)", js: true do
    user_1 = create(:user)
    login_as(user_1, :scope => :user)

    user_2 = create(:user)

    collection = create(:collection, user: user_2)

    visit "/collections/#{collection.id}"

    expect(page).to_not have_text("delete this collection")
    expect(page).to_not have_text("edit this collection")
  end

  scenario "a visitor (non-logged in) can see a collection if it's public or open" do
    # visitor not logged in
    user = create(:user)
    collection = create(:collection, user: user)
    # can access and view a collection
    visit "/collections/#{collection.id}"
    expect(page).to have_text(collection.title)
    expect(page).to have_text(collection.tagline)
    expect(page).to have_text(collection.description)
    # but can't edit it or delete it
    expect(page).to_not have_text("delete this collection")
    expect(page).to_not have_text("edit this collection")
    expect(page).to_not have_text("add a resource")

    # same spec with collection status: is_open
    # visitor not logged in
    user = create(:user)
    collection2 = create(:collection, user: user, status: :is_open)
    # can access and view a collection
    visit "/collections/#{collection2.id}"
    expect(page).to have_text(collection2.title)
    expect(page).to have_text(collection2.tagline)
    expect(page).to have_text(collection2.description)
    # but can't edit it or delete it
    expect(page).to_not have_text("delete this collection")
    expect(page).to_not have_text("edit this collection")
    expect(page).to_not have_text("add a resource")
  end

  scenario "a visitor (non-logged in) can't see a collection if it's private" do
     # visitor not logged in
    user = create(:user)
    collection = create(:collection, user: user, status: :is_private)
    # can access and view a collection
    visit "/collections/#{collection.id}"
    expect(page).to have_text(collection.title)
    expect(page).to have_text(collection.tagline)
    expect(page).to have_text(collection.description)
    # but can't edit it or delete it
    expect(page).to_not have_text("delete this collection")
    expect(page).to_not have_text("edit this collection")
    expect(page).to_not have_text("add a resource")
  end

  scenario "a user (logged in) can see a collection (public, open or private)" do
    # user logged in
    user_1 = create(:user)
    login_as(user_1, :scope => :user)

    user_2 = create(:user)

    collection = create(:collection, user: user_2)
    collection_2 = create(:collection, user: user_2, status: :is_open)
    collection_3 = create(:collection, user: user_2, status: :is_private)

    # can access and view a collection if it's public
    visit "/collections/#{collection.id}"
    expect(page).to have_text(collection.title)
    expect(page).to have_text(collection.tagline)
    expect(page).to have_text(collection.description)
    expect(page).to_not have_text("delete this collection")
    expect(page).to_not have_text("edit this collection")
    expect(page).to_not have_text("add a resource")

    # can access and view a collection if it's open
    visit "/collections/#{collection_2.id}"
    expect(page).to have_text(collection_2.title)
    expect(page).to have_text(collection_2.tagline)
    expect(page).to have_text(collection_2.description)
    expect(page).to_not have_text("delete this collection")
    expect(page).to_not have_text("edit this collection")
    expect(page).to_not have_text("add a resource")

    # can access and view a collection if it's open
    visit "/collections/#{collection_3.id}"
    expect(page).to have_text(collection_3.title)
    expect(page).to have_text(collection_3.tagline)
    expect(page).to have_text(collection_3.description)
    expect(page).to_not have_text("delete this collection")
    expect(page).to_not have_text("edit this collection")
    expect(page).to_not have_text("add a resource")
  end

  scenario "a user (logged in) can interact with a collection if it's public", js: true do
    # user logged in
    user_1 = create(:user)
    login_as(user_1, :scope => :user)
    user_2 = create(:user)
    collection = create(:collection, user: user_2)
    resource = create(:resource, collection: collection)
    # can access and view a collection
    visit "/collections/#{collection.id}"
    # can upvote resources
    upvote_before = find_link(class: ['upvote-btn'], :visible => :all).text.to_i
    upvote_link = find_link(class: ['upvote-btn'], :visible => :all)
    click_link(class: ['upvote-btn'])
    # capybara/poltergeist need to wait 2 sec (or maybe less) for the ajax call (turbolink) to come back.
    sleep 2
    expect(user_1.voted_up_on? resource).to be true
    # post comments
    comment = 'Lorem ipsium Lorem ipsium Lorem ipsium Lorem ipsium'
    fill_in 'Content', with: comment
    click_on "add a comment"
    expect(page).to have_text(comment)
  end

  scenario "a user (logged in) can interact with a collection if it's open", js: true do
    # user logged in
    user_1 = create(:user)
    login_as(user_1, :scope => :user)
    user_2 = create(:user)
    collection = create(:collection, user: user_2, status: :is_open)
    resource = create(:resource, collection: collection)
    # can access and view a collection
    visit "/collections/#{collection.id}"
    # can upvote resources
    upvote_before = find_link(class: ['upvote-btn'], :visible => :all).text.to_i
    upvote_link = find_link(class: ['upvote-btn'], :visible => :all)
    click_link(class: ['upvote-btn'])
    # capybara/poltergeist need to wait 2 sec (or maybe less) for the ajax call (turbolink) to come back.
    sleep 2
    expect(user_1.voted_up_on? resource).to be true
    # post comments
    comment = 'Lorem ipsium Lorem ipsium Lorem ipsium Lorem ipsium'
    fill_in 'Content', with: comment
    click_on "add a comment"
    expect(page).to have_text(comment)
  end

  scenario "a user (logged in) can star a collection (open or public)", js: true do
    # user logged in
    user_1 = create(:user)
    login_as(user_1, :scope => :user)
    user_2 = create(:user)
    collection = create(:collection, user: user_2)
    # can access and view a collection
    visit "/collections/#{collection.id}"
    like_link_class = "like-collection-#{collection.id}"
    click_link like_link_class
    sleep 1
    vote = user_1.voted_up_on? collection
    expect(vote).to be true
    # now with an open collection
    collection_open = create(:collection, user: user_2, status: :is_open)
    visit "/collections/#{collection_open.id}"
    like_link_class = "like-collection-#{collection_open.id}"
    click_link like_link_class
    sleep 1
    vote = user_1.voted_up_on? collection
    expect(vote).to be true
  end

  scenario "a user (logged in) can follow a collection (open or public)" do
    # user logged in
    user_1 = create(:user)
    login_as(user_1, :scope => :user)
    user_2 = create(:user)
    collection = create(:collection, user: user_2)
    # can access and view a collection
    visit "/collections/#{collection.id}"
    like_link_class = "follow-collection-#{collection.id}"
    click_link like_link_class
    sleep 1
    follow = user_1.following?(collection)
    expect(follow).to be true
    # same specs with an collection (status: is_open)
    collection_open = create(:collection, user: user_2, status: :is_open)
    visit "/collections/#{collection_open.id}"
    like_link_class = "follow-collection-#{collection_open.id}"
    click_link like_link_class
    sleep 1
    follow = user_1.following?(collection)
    expect(follow).to be true
  end

end
