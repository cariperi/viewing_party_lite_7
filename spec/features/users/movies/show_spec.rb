require 'rails_helper'

RSpec.describe '/users/:id/movies/:id' do
  before(:each) do
    VCR.use_cassette('test_for_links_top_movies', :allow_playback_repeats => true) do
      @user1 = create(:user)

      visit user_discover_path(@user1)

      click_button 'Find Top Rated Movies'

      movies = MoviesFacade.new.get_movies
      @movie = movies.first

      within(first('.movie')) do
        VCR.use_cassette('test_individual_movie', :allow_playback_repeats => true) do
          click_link(@movie.title)

          @selected_movie = MoviesFacade.new(nil, @movie.id).get_movie_details
        end
      end
    end
  end

  describe 'When I visit a movies details page' do
    VCR.use_cassette('test_individual_movie', :allow_playback_repeats => true) do
    it 'should have a button that links to a page to create a new viewing party' do
      expect(page).to have_button('Create Viewing Party')

      click_button 'Create Viewing Party'

      expect(current_path).to eq(new_user_movie_viewing_party_path(@user1, @movie.id))
    end

    it 'should have a button that links to the users discover page' do
      expect(page).to have_button('Discover Page')

      click_button 'Discover Page'

      expect(current_path).to eq(user_discover_path(@user1))
    end

    it 'should have information about the specific movie' do
      expect(page).to have_content(@selected_movie.title)
      expect(page).to have_content("Vote Average: #{@selected_movie.vote_average}")
      expect(page).to have_content("Runtime: 2h 55m")

      @selected_movie.genres.each do |genre|
        expect(page).to have_content(genre)
      end

      expect(page).to have_content(@selected_movie.summary)

      expect(page).to have_css('.cast', maximum: 10)

      @selected_movie.cast.each do |cast_member|
        expect(page).to have_content(cast_member[:character])
        expect(page).to have_content(cast_member[:name])
      end

      expect(page).to have_content("#{@selected_movie.reviews.count} Reviews")

      @selected_movie.reviews.each do |review|
        expect(page).to have_content(review[:author])
        expect(page).to have_content(review[:content])
      end
    end
    end
  end
end
