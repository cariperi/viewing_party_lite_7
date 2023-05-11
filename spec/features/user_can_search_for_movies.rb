require 'rails_helper'

feature 'user can search for movies' do
  before(:each) do
    @user1 = create(:user)
  end

  scenario 'user clicks on the Find Top Rated Movies button', :vcr do

    visit user_discover_path(@user1)

    click_button 'Find Top Rated Movies'

    expect(current_path).to eq(user_movies_path(@user1))

    expect(page).to have_css('.movie', maximum: 20)

    within(first('.movie')) do
      expect(page).to have_css('.title')
      expect(page).to have_css('.vote_avg')
    end
  end

  scenario 'user enters a keyword and clicks on the Search button', :vcr do
    visit user_discover_path(@user1)

    fill_in :keyword, with: 'Cinderella'
    click_button 'Search'

    expect(current_path).to eq(user_movies_path(@user1))

    expect(page).to have_css('.movie', maximum: 20)

    within(first('.movie')) do
      expect(page).to have_css('.title')
      expect(page).to have_css('.vote_avg')
    end
  end
end
