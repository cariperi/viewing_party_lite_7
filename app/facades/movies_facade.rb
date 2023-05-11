class MoviesFacade
  attr_reader :keyword, :movie_id

  def initialize(keyword = nil, movie_id = nil)
    @keyword = keyword
    @movie_id = movie_id
  end

  def get_movies
    service = MovieService.new

    json = @keyword.nil? ? service.get_top_movies : service.search_movies_by_title(@keyword)

    @movies = create_movies(json[:results])
  end

  def get_movie_details
    service = MovieService.new

    details = service.get_details(@movie_id)
    reviews = service.get_reviews(@movie_id)
    cast = service.get_cast(@movie_id)

    @movie = create_movie(details, reviews, cast)
  end

  private

  def create_movies(movie_data)
    movie_data.map do |data|
      Movie.new(data)
    end
  end

  def create_movie(details, reviews, cast)
    data = {
      id: details[:id],
      title: details[:title],
      vote_average: details[:vote_average],
      runtime: details[:runtime],
      genres: get_genres(details[:genres]),
      summary: details[:overview],
      url: format_url(details[:poster_path]),
      reviews: reviews[:results],
      cast: cast[:cast].first(10)
    }
    Movie.new(data)
  end

  def get_genres(data)
    return nil if data.nil?

    data.map do |genre_hash|
      genre_hash[:name]
    end
  end

  def format_url(data)
    "https://image.tmdb.org/t/p/original#{data}"
  end
end
