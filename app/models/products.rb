class  Products < ActiveRecord::Base
  #validates_uniqueness_of :product_id, scope: :name
  self.table_name = "products"
  before_create :set_create_time
  before_update :set_update_time

  def self.search_by_keyword(params)
    keyword = params[:keyword]

    query = where(:item_code => params[:item_code], :delete_flag => 0)
    query = query.where('name LIKE :keyword OR maker_name LIKE :keyword OR description LIKE :keyword', keyword: "%#{keyword}%")
  end

  def self.search(params)
    query = where(:item_code => params[:item_code], :delete_flag => 0)
    query = query.where("maker_name LIKE '%#{params[:maker]}%'") if(params[:maker].present?)
    query = query.where("name LIKE '%#{params[:product]}%'") if(params[:product].present?)
    query = query.order("id DESC") 
  end
  
  def save_record(params)
    self.name		  = params[:name]
    self.maker_id	  = params[:maker_id]
    self.maker_name	  = params[:maker_name]
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
