class MoviesFacade
  def initialize(keyword = nil)
    @keyword = keyword
  end

  def get_movies
    service = MovieService.new

    json = @keyword.nil? ? service.get_top_movies : service.search_movies_by_title(@keyword)

    @movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end