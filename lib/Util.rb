require 'yaml'

class Util
  @category = YAML.load_file("config/categories.yml")
  @category2 = YAML.load_file("config/categories2.yml")

  def self.main_category
    return @category["main_category"]
  end

  def self.categories
    return @category["categories"]
  end

  def self.category_items
    return @category["category_items"]
  end

  def self.main_category2
    return @category2["main_category"]
  end

  def self.categories2
    return @category2["categories"]
  end
end
