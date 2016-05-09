require 'yaml'

class Util
  @category = YAML.load_file("config/categories.yml")

  def self.main_category
    return @category["main_category"]
  end

  def self.categories
    return @category["categories"]
  end

  def self.category_items
    return @category["category_items"]
  end
end
