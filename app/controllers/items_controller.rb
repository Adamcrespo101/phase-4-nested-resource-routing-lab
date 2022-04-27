class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :err_response
before_action :find_user


  def index
    if @user
    items = @user.items
    else 
      items = Item.all
    end
    render json: items, include: :user
end

def show 
item = Item.find(params[:id])
render json: item, status: 200
end

def create 
  user = @user
item = user.items.create(item_params)
render json: item, status: :created
end

private

def find_user 
  @user = User.find(params[:user_id])
end

def err_response
  render json: {message: "user not found"}, status: :not_found
end

def item_params
  params.permit(:name, :description, :price, :user_id)
end


end
