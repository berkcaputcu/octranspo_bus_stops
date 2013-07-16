class FavoritesController < ApplicationController

	before_filter :authenticate_user!

	def index
		@favorites = current_user.favorites

		respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /favorites/1.json
  def show
  	@favorite = Favorite.find(params[:id])

  	respond_to do |format|
  		format.json { render json: @favorite }
  	end
  end

  # POST /favorites
  # POST /favorites.json
  def create
  	@favorite = current_user.favorites.create(params[:favorite])

  	respond_to do |format|
  		format.json { render json: @favorite, status: :created, location: @favorite }
  	end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
  	@favorite = Favorite.find(params[:id])
  	@favorite.destroy

  	respond_to do |format|
  		format.html { redirect_to favorites_url }
  		format.json { head :no_content }
  	end
  end
  
end
