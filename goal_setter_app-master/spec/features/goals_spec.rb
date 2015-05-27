require 'spec_helper'
require 'rails_helper'
require 'byebug'
feature "user page" do

  before(:each) do
    sign_in_as_tester
    goal_title = "VERY SPECIFIC TITLE"
  end

  given(:goal_title){ "VERY SPECIFIC TITLE" }

  feature "user's personal page" do

    scenario "user sees form for new goals" do
      expect(page).to have_content('New Goal')
      expect(page).to have_button 'Submit New Goal'
    end

    scenario "user sees all of their goals on their page" do
      user = User.find_by(username: 'testing_username')
      goal1 = user.goals.create!(title: 'goal1', private_or_public: 'private')
      goal2 = user.goals.create!(title: 'goal2', private_or_public: 'private', due_date: 2.days.ago.to_date)
      visit user_url(user)
      expect(page).to have_content(goal1.title)
      expect(page).to have_content(goal2.title)

      expect(page).to_not have_content("goal3")
    end

    scenario "user can complete goal without having to leave page" do
      submit_goal(goal_title, 'public')
      click_button 'complete goal'
      expect(page).to have_content("uncomplete goal")
    end

    scenario "user sees links to edit goals next to all listed goals" do
      expect(page).to_not have_content("edit")
      submit_goal(goal_title, 'public')
      expect(page).to have_content("edit")
    end

    feature "goal submission" do

      feature "invalid goal submission" do
        scenario "error messages appear on screen after invalid goal submission" do
          submit_goal(goal_title)
          expect(page).to have_content("must be public or private")
        end
      end


      feature "valid goal submission" do
        scenario "user can submit new goals" do
          user = User.find_by(username: 'testing_username')
          submit_goal(goal_title, 'private')
          expect(user.goals.count).to eq(1)
          # byebug
          expect(page).to have_content('VERY SPECIFIC TITLE')
        end

        feature "Goal edit page" do
          before(:each) do
            submit_goal(goal_title, 'public')
            click_on 'edit'
          end

          scenario "user can access edit page" do
            expect(page).to have_content("Edit Goal")
          end

          scenario "user can modify their goal" do
            fill_in "Notes", with: "this is a note"
            click_button 'Update Goal'
            expect(page).to have_content("testing_username's Goals")
            expect(page).to have_content("this is a note")
          end
        end
      end
    end
  end

  feature "another user's page" do

    before(:each) do
      submit_goal(goal_title, 'public')
      submit_goal('a private goal', 'private')
      click_on 'Sign Out'
      sign_in_as_other_tester
      visit(user_url(1))
    end

    scenario "user sees public goals" do
      expect(page).to have_content('VERY SPECIFIC TITLE')
    end

    scenario "user does not see private goals" do
      expect(page).to_not have_content('a private goal')
    end

    scenario "user cannot access edit page for another user's goal" do
      visit(edit_goal_url(1))
      expect(page).to have_content("Your not allowed to access this page")
      expect(page).to_not have_content('Edit Goal')
    end

  end

  scenario "seen goals are in sorted order by due date"

  scenario "seen goals are grouped by completed goals and incomplete goals"

end
