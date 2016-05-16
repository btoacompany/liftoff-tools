require 'Util.rb' 

class Category < ActiveRecord::Base
  self.table_name = "sub_category"

  def get_main_category2
    return Util.main_category2
  end

  def get_categories2
    return Util.categories2
  end

  def get_main_category
    return Util.main_category 
  end

  def get_categories
    return Util.categories
  end

  def get_category_items
    return Util.category_items
  end
end
