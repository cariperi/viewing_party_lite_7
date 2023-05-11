class Users::MoviesController < ApplicationController
  before_action :get_user

  def index
    @facade = keyword_search? ? MoviesFacade.new(params[:keyword], nil) : MoviesFacade.new
  end

  def show
    @movie = MoviesFacade.new(nil, params[:id]).get_movie_details
  end

  private
  def get_user
    @user = User.find(params[:user_id])
  end

  def keyword_search?
    params[:keyword].present?
  end
end