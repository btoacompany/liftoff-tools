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
      type = v[:type]

      if (type == 0)
	search_params.merge!({k => v[:specs]})
      elsif (type == 1)
	search_params.merge!(k => {"$in": v[:specs]}.stringify_keys)
      elsif (type == 2)
	unless (v[:specs].all?(&:empty?))
	  min = v[:specs][0].present? ? v[:specs][0].to_i : nil
	  max = v[:specs][1].present? ? v[:specs][1].to_i : nil

	  range = {'$gte': min, '$lte': max}.stringify_keys
	  range = {'$gte': min}.stringify_keys if max.nil?
	  range = {'$lte': max}.stringify_keys if min.nil?

	  search_params.merge!({k => range})
	end
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
	:item_code => params[:item_code],
	:update_time => t,
      }
    end

    Mongolib.update(@@collection, {:product_id => product_id}, params)
  end

  def set_time
    return Time.now.strftime("%Y-%m-%d %H:%M:%S")
  end
end
