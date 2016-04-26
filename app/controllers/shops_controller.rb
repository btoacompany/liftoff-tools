#coding:utf-8

class ShopsController < ApplicationController
  def index
    @shops = Shops.where(:delete_flag => 0)
  end

  def create
    #do nothing
  end

  def create_action
    shop = Shops.new
    shop.save_record(params)
    redirect_to_index
  end

  def edit
    @shops = Shops.where(:id => params[:id], :delete_flag => 0)
  end
  
  def edit_action
    shop = Shops.find(params[:id])
    shop.save_record(params)
    redirect_to_index
  end

  def delete_action
    shop = Shops.find(params[:id])
    shop.delete_record
    redirect_to_index
  end

  def redirect_to_index
    redirect_to "/shops" 
  end
end
