class Movie
  attr_reader :id, :title, :vote_average
  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
  end
end