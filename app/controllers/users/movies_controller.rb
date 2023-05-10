class Users::MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end
end