#coding:utf-8

class ProductsController < ApplicationController
  before_filter :init

  def init 
    c = Category.new
    @main_category = c.get_main_category
    @categories = c.get_categories
  end

  def index
    @temp = Products.where(:delete_flag => 0)

    item_code="1000101" #TODO: get value later
    items = Items.where(:item_code => item_code).first
    @item_specs = items[:specs].split(",")

=begin
    products = Products.where(:delete_flag => 0)
    product_specs = ProductSpecs.new
    data = {}
    @products = []

    products.each do | product |
      specs = product_specs.find(:product_id => product[:id])
      specs.each do | s |
      end
    end
=end    
  end

  def create
    @makers = Makers.where(:delete_flag => 0).order("name asc")
    @items = Items.select("item_code, name, category_id").where(:delete_flag => 0)
  end

  def create_specs
    set_specs_page
  end

  def create_confirm
    set_confirm_page
  end

  def create_shops
    @shops = Shops.where(:delete_flag => 0)

    #--for saving product info and specs--
    product_params = session[:items].symbolize_keys
    product = Products.new
    product.save_record(product_params)
    @product_id = product.id

    product_specs = ProductSpecs.new
    spec_params = session[:specs]
    spec_keys = spec_params["spec_keys"].split(",")
    specs_info = {}

    spec_keys.each do | key |
      specs_info[key] = {
	:content => spec_params[key],
	:type => spec_params["#{key}_display_type"],
      }

      if (spec_params["#{key}_display_type"].to_i == 2)
	specs_info[key].merge!({:metric => spec_params["#{key}_metric"]})
      end
    end

    item_code = product_params[:item_code]
    spec_params.merge!({
      :product_id => @product_id,
      :item_code => item_code,
      :specs => specs_info
    })

    product_specs.save(spec_params)
  end

  def create_action
    product_shops = ProductShops.new
    product_shops.save_record(params)
  end

  def edit
    @makers = Makers.where(:delete_flag => 0).order("name asc")
    @items = Items.select("item_code, name, category_id").where(:delete_flag => 0)
    @products = Products.find(params[:id])
  end
  
  def edit_specs
    set_specs_page

    products = Products.find(params[:product_id])
    @spec_changed = 1

    if (params[:item_code].to_i == products.item_code)
      @spec_changed = 0
      product_id = session[:items][:product_id].to_i
      product_specs = ProductSpecs.new
      specs = product_specs.find({:product_id => product_id}).first
      @specs = specs[:specs]
    end
  end

  def edit_confirm
    set_confirm_page
  end

  def edit_shops
    product_params = session[:items].symbolize_keys
    @product_id = product_params[:product_id].to_i 

    @shops = Shops.where(:delete_flag => 0)
    @product_shops = ProductShops.where(:product_id => @product_id, :delete_flag => 0) 

    update_info_and_specs(product_params)
  end
  
  def edit_action
    product_shops = ProductShops.find(params[:id].to_i)
    
    if (params[:delete_flag].to_i == 1)
      product_shops.delete_record 
    else
      product_shops.save_record(params)
    end
  end
  
  def delete_action
    product = Products.find(params[:id])
    product.delete_record
    redirect_to_index 
  end

  def set_specs_page
    session[:items] = params
    @items = Items.where(:item_code => params[:item_code])
    @spec_keys = @items[0][:specs] 
    @item_specs = @items[0][:specs].split(",")
  end

  def set_confirm_page
    session[:items].symbolize_keys!
    session[:specs] = params
    
    @makers	= Makers.where(:id => session[:items][:maker_id]).first
    @items	= Items.where(:item_code => session[:items][:item_code]).first
    @main_cat	= MainCategory.where(:main_category_id => session[:items][:main_category_id]).first
    @sub_cat	= Category.where(:category_id => session[:items][:category_id]).first
    @spec_keys	= params[:spec_keys].split(",")

    session[:items][:description].strip!
  end

  def update_info_and_specs(product_params)
    product = Products.find(@product_id)
    product.save_record(product_params)

    spec_params = session[:specs]
    spec_keys = spec_params["spec_keys"].split(",")
    specs_info = {}

    spec_keys.each do | key |
      specs_info[key] = {
	:content => spec_params[key],
	:type => spec_params["#{key}_display_type"],
      }

      if (spec_params["#{key}_display_type"].to_i == 2)
	specs_info[key].merge!({:metric => spec_params["#{key}_metric"]})
      end
    end

    spec_params.merge!({
      :product_id => @product_id,
      :item_code => product_params[:item_code],
      :specs => specs_info
    })

    product_specs = ProductSpecs.new
    product_specs.update(spec_params)
  end

  def redirect_to_index
    redirect_to "/items" 
  end
end
