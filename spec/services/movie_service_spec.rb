require 'rails_helper'

describe MovieService do
  context 'instance methods', :vcr do
    context '#get_top_movies' do
      it 'returns movie data' do
        search = MovieService.new.get_top_movies
        expect(search).to be_a Hash
        expect(search[:results]).to be_an Array

        movie_data = search[:results].first

        expect(movie_data).to have_key :id
        expect(movie_data[:id]).to be_a(Integer)

        expect(movie_data).to have_key :title
        expect(movie_data[:title]).to be_a(String)

        expect(movie_data).to have_key :vote_average
        expect(movie_data[:vote_average]).to be_a(Float)
      end
    end

    context '#search_movies_by_title(keyword)' do
      it 'returns movie data' do
        search = MovieService.new.search_movies_by_title('Cinderella')
        expect(search).to be_a Hash
        expect(search[:results]).to be_an Array

        movie_data = search[:results].first

        expect(movie_data).to have_key :id
        expect(movie_data[:id]).to be_a(Integer)

        expect(movie_data).to have_key :title
        expect(movie_data[:title]).to be_a(String)

        expect(movie_data).to have_key :vote_average
        expect(movie_data[:vote_average]).to be_a(Float)
      end
    end
  end
end
