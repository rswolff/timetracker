class TagsController < ApplicationController
  def new
    @tag = Tag.new
    @categories = @current_user.categories
    
    @tags = params[:tags].split(",")
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
  end
end
