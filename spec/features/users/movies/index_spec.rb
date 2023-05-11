require 'rails_helper'

RSpec.describe '/users/:id/movies', type: :feature do
  before(:each) do
    @user1 = create(:user)
  end

  describe 'When I visit the Movie Results page', :vcr do
    it 'I see a button to return to the Discover page' do
      visit user_movies_path(@user1)

      expect(page).to have_button 'Discover Page'
    end

    it 'When I click on the button I am returned to my Discover page' do
      visit user_movies_path(@user1)
      click_button 'Discover Page'

      expect(current_path).to eq(user_discover_path(@user1))
    end

    it 'I see movie titles that are links to their Movie details pages from Top Movies' do
    VCR.use_cassette('test_for_links_top_movies', :allow_playback_repeats => true) do
      visit user_discover_path(@user1)

      click_button 'Find Top Rated Movies'

      movies = MoviesFacade.new.get_movies
      movie = movies.first

      expect(page).to have_css('.title')

      within(first('.movie')) do
        click_link(movie.title)
      end

      expect(current_path).to eq(user_movie_path(@user1.id, movie.id))
    end
    end

    it 'I see movie titles that are links to their Movie details pages from Searched Movies' do
    VCR.use_cassette('test_for_links_search_movies', :allow_playback_repeats => true) do
      visit user_discover_path(@user1)

      fill_in :keyword, with: 'Cinderella'
      click_button 'Search'

      movies = MoviesFacade.new('Cinderella').get_movies
      movie = movies.first

      expect(page).to have_css('.title')

      within(first('.movie')) do
        click_link(movie.title)
      end

      expect(current_path).to eq(user_movie_path(@user1.id, movie.id))
    end
    end
  end
end
