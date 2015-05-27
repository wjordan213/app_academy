require 'spec_helper'
require 'rails_helper'
require 'byebug'

feature 'user comments' do
  before(:each) do
    sign_up_as_tester
    submit_goal('Do things', 'public')
    click_on('Sign Out')
    sign_up_as_other_tester
    visit(user_url(1))
  end

  feature 'on other users' do
    scenario "sees a comment form on a user show page" do
      expect(page).to have_content("Comment on this user")
    end

    scenario "can leave a comment through the form" do
      submit_comment("this is a comment")
      expect(page).to have_content("comment submitted")
    end

    scenario "can see comments on another user's profile" do
      submit_comment("this is a comment")
      expect(page).to have_content("this is a comment")
    end
  end

  feature 'on goals' do
    scenario "sees a comment form on a goal page" do
      save_and_open_page
      click_on 'Do things'
      expect(page).to have_content("Comment on this goal")
    end

    scenario "can leave a comment through the form" do
      click_on 'Do things'
      submit_comment("this is a comment")
      expect(page).to have_content 'comment submitted'
    end

    scenario "can see comments on goal profile" do
      submit_comment("this is a comment")
      expect(page).to have_content("this is a comment")
    end

  end

end
