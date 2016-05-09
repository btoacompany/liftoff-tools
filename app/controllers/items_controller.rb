#coding:utf-8

class ItemsController < ApplicationController
  before_filter :init

  def init 
    c = Category.new
    @main_category = c.get_main_category
    @categories = c.get_categories
  end

  def index
    @items = Items.where(:delete_flag => 0).order("item_code")
  end

  def create
    #do nothing
  end

  def create_action
    params[:specs] = specs_fix(params[:specs])
    item_codes = Items.where(:category_id => params[:category_id], :delete_flag =>
    0).reverse.first

    params[:item_code] = item_codes.item_code + 1

    item = Items.new
    item.save_record(params)
    redirect_to_index 
  end

  def edit
    @item = Items.find(params[:id])
  end
  
  def edit_action
    params[:specs] = specs_fix(params[:specs])

    item = Items.find(params[:id])
    item.save_record(params)
    redirect_to_index 
  end

  def delete_action
    item = Items.find(params[:id])
    item.delete_record
    redirect_to_index 
  end

  def redirect_to_index
    redirect_to "/items" 
  end

  def specs_fix(specs)
    arr_specs = specs.split(",")
    arr_specs.reject! { | spec | spec.empty? }
    arr_specs.uniq!
    arr_specs.map{ | spec | spec.strip }.compact.join(",")
  end
end
