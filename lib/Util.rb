require 'yaml'

class Util
  @category = YAML.load_file("config/categories.yml")

  def self.main_category
    return @category["main_category"]
  end

  def self.categories
    @category["categories"].each do | key, val |
    end
  end
end