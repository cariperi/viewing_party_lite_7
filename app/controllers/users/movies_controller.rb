class Users::MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if keyword_search?
      @facade = MoviesFacade.new(params[:keyword], nil)
    else
      @facade = MoviesFacade.new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @movie = MoviesFacade.new(nil, params[:id]).get_movie_details
  end

  private

  def keyword_search?
    params[:keyword].present?
  end
end