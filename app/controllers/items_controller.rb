#coding:utf-8

class ItemsController < ApplicationController
  before_filter :init

  def init 
    c = Category.new
    @main_category = c.get_main_category2
    @categories = c.get_categories2
  end

  def index
    @items = Items.where(:delete_flag => 0).order("item_code")
  end

  def create
    #do nothing
  end

  def create_specs
    set_specs_page
  end

  def create_action
    set_items_info

    item_codes = Items.where(:category_id => session[:items][:category_id], :delete_flag => 0).reverse.first

    unless item_codes.blank?
      item_code = item_codes.item_code + 1
    else
      item_code = session[:items][:category_id] + "01" 
    end

    session[:items][:item_code] = item_code.to_i

    item = Items.new
    item.save_record(session[:items])
    redirect_to_index 
  end

  def edit
    @item = Items.find(params[:id])
  end

  def edit_specs
    set_specs_page
    @spec_changed = 1

    if(params[:old_specs] == params[:specs])
      @spec_changed = 0
      @items = Items.find(params[:id])
      @specs = @items.specs.split(",")
      @type = @items.display_type.split(",")
      @metric = @items.metric.split(",")
    end
  end
  
  def edit_action
    set_items_info

    item = Items.find(session[:items][:id])
    item.save_record(session[:items])
    redirect_to_index 
  end

  def delete_action
    item = Items.find(params[:id])
    item.delete_record
    redirect_to_index 
  end

  def set_specs_page
    session[:items] = params
    params[:specs] = specs_fix(params[:specs])
    @spec_keys = params[:specs].split(",")
  end

  def set_items_info
    session[:items].symbolize_keys!
    params[:display_type] = params[:display_type].join(",")
    params[:metric] = (params[:metric].map{ |val| val.empty? ? "nil" : val }).join(",")
    session[:items].merge!({:display_type => params[:display_type], :metric => params[:metric]})
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
