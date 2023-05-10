require 'rails_helper'

RSpec.describe '/users/:id/movies', type: :feature do
  before(:each) do
    @user1 = create(:user)
  end

  describe 'When I visit the Movie Results page' do
    it 'I see a button to return to the Discover page' do
      visit user_movies_path(@user1)

      expect(page).to have_button 'Discover Page'
    end

    it 'When I click on the button I am returned to my Discover page' do
      visit user_movies_path(@user1)
      click_button 'Discover Page'

      expect(current_path).to eq(user_discover_path(@user1))
    end
  end
end
