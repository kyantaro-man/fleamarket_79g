class CategoriesController < ApplicationController

  def index
    @parents = Category.all.where(ancestry: nil)
  end
end
