require 'spec_helper'
require 'rails_helper'

# spec heloer


feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

    feature "signing up a user" do
      scenario "user can't sign-in in with a blank password" do
        sign_up('testing_username','')
        expect(page).to have_content "Password is too short"
        expect(page).to have_content "New user"
      end

      scenario "user can't sign-in with a blank username" do
        sign_up('','password')
        expect(page).to have_content "Username can't be blank"
        expect(page).to have_content "New user"
      end

      scenario "shows username on the homepage after signup"  do
        sign_up_as_tester
        expect(page).to have_content 'testing_username'
        expect(page.current_path).to_not eq new_user_url
      end

    end

end

  feature "logging in" do

    scenario "shows username on the homepage after login" do
      sign_in_as_tester
      expect(page).to have_content 'testing_username'
      expect(page).to have_content 'Sign Out'
    end

    scenario "redirects to user show page at login" do
      sign_in_as_tester
      expect(page).to have_content "testing_username's Goals"
    end

  end

  feature "logging out" do

    scenario "begins with logged out state" do
      visit root_url
      expect(page).to have_content 'Username'
      expect(page).to have_content 'Password'
    end

    scenario "doesn't show username on the homepage after logout" do
      sign_up_as_tester
      click_on "Sign Out"
      expect(page).to_not have_content "testing_username"
    end

  end
