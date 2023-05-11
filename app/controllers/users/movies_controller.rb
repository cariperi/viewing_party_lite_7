class Users::MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if keyword_search?
      @facade = MoviesFacade.new(params[:keyword])
    else
      @facade = MoviesFacade.new
    end
  end

  def show
    @user = User.find(params[:user_id])
    #params[:id] is movie id
  end

  private

  def keyword_search?
    params[:keyword].present?
  end
end