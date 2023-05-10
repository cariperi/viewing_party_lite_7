require 'rails_helper'

RSpec.describe '/users/:id/discover', type: :feature do
  before(:each) do
    @user1 = create(:user)
    visit user_discover_path(@user1)
  end

  describe 'When I visit the users discover page' do
    it 'has a title' do
      expect(page).to have_content('Discover Movies')
    end

    it 'I see a button to Find Top Rated Movies' do
      expect(page).to have_button('Find Top Rated Movies')
    end

    it 'I see a text field to enter keyword(s) to search by movie title' do
      expect(page).to have_field(:keyword)
    end

    it 'I see a button to Search by Title' do
      expect(page).to have_button('Search')
    end
  end

  describe 'When I click on Find Top Rated Movies', :vcr do
    it 'I am taken to the Movie Results Page' do
      click_button 'Find Top Rated Movies'

      expect(current_path).to eq(user_movies_path(@user1))
    end
  end

  describe 'When I click on Search', :vcr do
    it 'I am taken to the Movie Results Page' do
      click_button 'Search'

      expect(current_path).to eq(user_movies_path(@user1))
    end
  end
end
