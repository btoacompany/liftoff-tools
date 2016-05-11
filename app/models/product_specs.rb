require 'Mongolib.rb'

class ProductSpecs
  Mongolib.connect
  @@collection = "product_specs"

  def find(params = {})
    Mongolib.find(@@collection, params)
  end

  def search(params = {})
    search_params = { :item_code => params[:item_code] }

    params[:specs].each do | k, v |
      type = v[:type] #TODO: get type from items

      if (type == 0)
	search_params.merge!({k => v[:specs]})
      elsif (type == 1)
	search_params.merge!({k => {'$gte': v[:specs].to_i, '$lte': 900}.stringify_keys})
      elsif (type == 2)
	search_params.merge!(k => {"$in": ["#{v[:specs]}"]}.stringify_keys)
      end
    end
    
    Mongolib.find(@@collection, search_params)
  end

  def distinct(field = "", cond = {})
    Mongolib.distinct(@@collection, field, cond)
  end

  def save(params = {})
    t = set_time
    params = {
      :product_id => params[:product_id],
      :item_code => params[:item_code],
      :specs => params[:specs],
      :create_time => t,
      :update_time => t,
      :delete_flag => 0
    }
    Mongolib.save(@@collection, params)
  end

  def update(params = {})
    t = set_time
    product_id = params[:product_id].to_i

    if params.has_key?(:delete_flag)
      params = {
	:update_time => t,
	:delete_flag => params[:delete_flag] 
      }
    else
      params = {
	:specs => params[:specs],
	:update_time => t,
      }
    end

    Mongolib.update(@@collection, {:product_id => product_id}, params)
  end

  def set_time
    return Time.now.strftime("%Y-%m-%d %H:%M:%S")
  end
end
