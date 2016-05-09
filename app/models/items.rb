class Items < ActiveRecord::Base
  self.table_name = "items"
  before_create :set_create_time
  before_update :set_update_time
  
  def save_record(params)
    self.item_code  = params[:item_code]
    self.name	    = params[:name]
    self.specs	    = params[:specs]
    self.description  = params[:description]
    self.category_id  = params[:category_id]
    self.main_category_id  = params[:main_category_id]
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
