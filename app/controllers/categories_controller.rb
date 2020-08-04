class CategoriesController < ApplicationController

  def index
  end

  def show
  end

  def new
    @children = Category.find(params[:id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end


end
