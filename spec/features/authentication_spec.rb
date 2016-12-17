require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  scenario "User can sign up" do
    visit "/users/sign_up"

    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Username", with: "johnny"
    fill_in "Email", with: "john.doe@example.com"
    fill_in "Password", with: "johnnythebest", match: :prefer_exact
    fill_in "Password confirmation", with: "johnnythebest", match: :prefer_exact

    click_button "Sign up"
    expect(page).to have_text("Welcome! You have signed up successfully.")
  end

  scenario "User can't sign up with missing informations" do
    visit "/users/sign_up"

    fill_in "Username", with: "johnny"
    fill_in "Email", with: "john.doe@example.com"
    fill_in "Password", with: "johnnythebest", match: :prefer_exact
    fill_in "Password confirmation", with: "johnnythebest", match: :prefer_exact

    click_button "Sign up"
    expect(page).to have_text("Please review the problems below:")
    expect(page).to have_text("can't be blank")
  end

  scenario "User can sign in" do
    user = create(:user)

    visit "/users/sign_in"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
    expect(page).to have_text("Signed in successfully.")
  end

  scenario "User can't sign in with invalid informations" do
    visit "/users/sign_in"

    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: Faker::Internet.password

    click_button "Log in"
    expect(page).to have_text("Invalid Email or password")
  end

  scenario "User can't sign in with missing informations" do
    visit "/users/sign_in"

    fill_in "Email", with: Faker::Internet.email

    click_button "Log in"
    expect(page).to have_text("Invalid Email or password")
  end

  scenario "User can edit his profile" do
    # visit "/users/edit"
    # test with a user, change the name, and check if the name is different after.
  end
end
