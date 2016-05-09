class  Products < ActiveRecord::Base
  #validates_uniqueness_of :product_id, scope: :name
  self.table_name = "products"
  before_create :set_create_time
  before_update :set_update_time
  
  def save_record(params)
    self.name		  = params[:name]
    self.maker_id	  = params[:maker_id]
    self.img_src	  = params[:img_src]
    self.description	  = params[:description]
    self.main_category_id = params[:main_category_id]
    self.category_id	  = params[:category_id]
    self.item_code	  = params[:item_code]
    self.msds_link	  = params[:msds_link]
    self.details_links	  = params[:details_links]
    self.orange_catalog_link   = params[:orange_catalog_link]
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
