require 'yaml'
class Test
  @category = YAML.load_file("config/categories.yml")
  main_category = @category["main_category"] 
  categories = @category["categories"] 
  items = {} 

  categories.each do |key, val|
    p "----------"
    p key
    p val
  end
end
