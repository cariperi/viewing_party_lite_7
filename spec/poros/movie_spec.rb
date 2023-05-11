require 'rails_helper'

RSpec.describe Movie do
  it 'exists' do
    data = {
      id: 1,
      title: 'Best Movie',
      vote_average: '10.0'
    }

    movie = Movie.new(data)

    expect(movie).to be_a Movie
    expect(movie.id).to eq(1)
    expect(movie.title).to eq('Best Movie')
    expect(movie.vote_average).to eq('10.0')
  end
end
