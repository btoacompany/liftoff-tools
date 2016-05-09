class ProductShops < ActiveRecord::Base
  self.table_name = "product_shops"
  before_create :set_create_time
  before_update :set_update_time
  
  def save_record(params)
    shops = Shops.find(params[:shop_id].to_i)

    self.shop_id      = params[:shop_id]
    self.shop_name    = shops[:name]
    self.product_id   = params[:product_id]
    self.product_url  = params[:product_url]
    self.img_src      = params[:img_src]
    self.price	      = params[:price]
    self.price_sale   = params[:price_sale]
    self.min_purchase = params[:min_purchase]
    self.stock_count  = params[:stock_count]
    self.stock_status = params[:stock_status]
    self.delete_flag  = params[:delete_flag]
    self.save
  end
  
  def delete_record
    self.delete_flag = 1
    self.save
  end

  def set_create_time 
    t = set_time
    self.create_time = t
    self.update_time = t
  end

  def set_update_time 
    t = set_time
    self.update_time = t
  end

  def set_time
    return Time.now.strftime("%Y-%m-%d %H:%M:%S")
  end
end
