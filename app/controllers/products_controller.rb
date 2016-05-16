#coding:utf-8

class ProductsController < ApplicationController
  before_filter :init

  def init 
    c = Category.new
    @main_category = c.get_main_category2
    @categories = c.get_categories2
  end

  def top
  end

  def items_list
    @cat_id = params[:cat_id]
    @items = Items.where(:category_id => @cat_id, :delete_flag => 0)
  end

  def index
    item_code = params[:item].present? ? params[:item] : "1000101"
    @items = Items.where(:category_id => params[:cat_id])
    @item = Items.where(:item_code => item_code).first
    item_specs = @item[:specs].split(",")

    @type = @item[:display_type].split(",")
    @metric = @item[:metric].split(",")

    spec_exist = 0
    spec_params = {}
    @specs = {}

    item_specs.each_with_index do | spec, i |
      #get all unique contents per spec on the selected item
      ps = ProductSpecs.new
      @specs[spec] = ps.distinct(
	"specs.#{spec}.content", 
	{:item_code => item_code.to_s, :delete_flag => 0}
      )

      #check if search by spec was triggered
      if (params[spec.to_sym].present?)
	spec_exist = 1
	spec_params["specs.#{spec}.content"] = {
	  :specs => params[spec],
	  :type => @type[i].to_i
	}
      end
    end
    params.merge!({:item_code => item_code})

    #get all product info
    products = {} 
    product_ids = []

    if (params[:keyword].present?) 
      products = Products.search_by_keyword(params)
    else
      products = Products.search(params)

      if ( spec_exist == 1 )
	ps = ProductSpecs.new
	ps_results = ps.search({:item_code => item_code, :specs => spec_params})

	product_ids = products.map{ | res | res[:id] }
	spec_product_ids = ps_results.map{ | res | res[:product_id] }
	product_ids = product_ids & spec_product_ids
	products = products.select {|k,v| product_ids.include?(k[:id])}
      end
    end

    #merge product info with specs info and append it in an instance array variable
    @products = [] 
    products.each do | product |
      ps = ProductSpecs.new
      ps_results = ps.find({:product_id => product[:id]}).first

      contents = {
	:product_id => product[:id],
	:name	    => product[:name],
	:maker_name => product[:maker_name],
	:img_src    => product[:img_src],
	:description  => product[:description],
	:msds_link    => product[:msds_link],
	:orange_catalog_link  => product[:orange_catalog_link],
	:details_links	=> product[:details_links],
	:specs	    => ps_results[:specs]
      }
      @products << contents
    end
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
    create_info_and_specs
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

    ProductShops.where(:product_id => params[:id], :delete_flag => 0).update_all(:delete_flag => 1)
    product_specs = ProductSpecs.new
    product_specs.update({:product_id => params[:id], :delete_flag => 1})
    redirect_to_index 
  end

  def set_specs_page
    session[:items] = params
    @items = Items.where(:item_code => params[:item_code]).first
    @spec_keys = @items[:specs] 
    @item_specs = @items[:specs].split(",")
    @type = @items[:display_type].split(",")
    @metric = @items[:metric].split(",")
  end

  def set_confirm_page
    session[:items].symbolize_keys!
    session[:specs] = params
    
    @makers	= Makers.where(:id => session[:items][:maker_id]).first
    session[:items].merge!({ :maker_name => @makers.name })

    @items	= Items.where(:item_code => session[:items][:item_code]).first
    @main_cat	= MainCategory.where(:main_category_id => session[:items][:main_category_id]).first
    @sub_cat	= Category.where(:category_id => session[:items][:category_id]).first
    @spec_keys	= params[:spec_keys].split(",")

    session[:items][:description].strip!
  end

  def create_info_and_specs
    product_params = session[:items].symbolize_keys
    item_code = product_params[:item_code]

    product = Products.new
    product.save_record(product_params)
    @product_id = product.id

    spec_params = set_spec_contents(item_code)
    product_specs = ProductSpecs.new
    product_specs.save(spec_params)
  end

  def update_info_and_specs(product_params)
    product = Products.find(@product_id)
    product.save_record(product_params)
    item_code = product_params[:item_code]

    spec_params = set_spec_contents(item_code)

    product_specs = ProductSpecs.new
    product_specs.update(spec_params)
  end

  def set_spec_contents(item_code)
    spec_params = session[:specs]
    spec_keys = spec_params["spec_keys"].split(",")
    specs_info = {}

    spec_keys.each do | key |
      type = spec_params["#{key}_display_type"].to_i
      content = (type == 2) ? spec_params[key].to_i : spec_params[key] 
      specs_info[key] = { :content => content }
    end

    spec_params.merge!({
      :product_id => @product_id,
      :item_code => item_code,
      :specs => specs_info
    })
    return spec_params
  end

  def redirect_to_index
    redirect_to "/items" 
  end
end
