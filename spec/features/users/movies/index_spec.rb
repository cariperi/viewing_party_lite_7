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

# When I visit the discover movies page,
# and click on either the Top Movies button or the Search button,
# I should be taken to the movies results page (users/:user_id/movies) where I see:

#  Title (As a Link to the Movie Details page)
#  Vote Average of the movie
# Details: There should only be a maximum of 20 results. The above details should be listed for each movie.
