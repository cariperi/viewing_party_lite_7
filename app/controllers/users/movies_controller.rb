class Users::MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @facade = keyword_search? ? MoviesFacade.new(params[:keyword], nil) : MoviesFacade.new
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