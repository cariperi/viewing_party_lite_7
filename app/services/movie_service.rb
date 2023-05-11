class MovieService
  def get_top_movies
    get_url("/3/movie/top_rated")
  end

  def search_movies_by_title(keyword)
    get_url("3/search/movie?include_adult=false&query=#{keyword}")
  end

  def get_details(id)
    get_url("/3/movie/#{id}")
  end

  def get_reviews(id)
    get_url("/3/movie/#{id}/reviews")
  end

  def get_cast(id)
    get_url("/3/movie/#{id}/credits")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = ENV["TMDB_API_KEY"]
    end
  end
end