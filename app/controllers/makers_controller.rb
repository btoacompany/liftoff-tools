#coding:utf-8

class MakersController < ApplicationController
  def index
    @makers = Makers.where(:delete_flag => 0)
  end

  def create
    #do nothing
  end

  def create_action
    maker = Makers.new
    maker.save_record(params)

    redirect_to_index 
  end

  def edit
    @makers = Makers.find(params[:id])
  end
  
  def edit_action
    maker = Makers.find(params[:id])
    maker.save_record(params)

    products = Products.where(:maker_id => maker.id).update_all(:maker_name => maker.name)

    redirect_to_index 
  end

  def delete_action
    maker = Makers.find(params[:id])
    maker.delete_record

    redirect_to_index 
  end

  def redirect_to_index
    redirect_to "/makers" 
  end
end
