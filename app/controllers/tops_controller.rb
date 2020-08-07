class TopsController < ApplicationController
  def index
    @items = Item.all
  end
end
