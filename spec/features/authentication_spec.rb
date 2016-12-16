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
end
