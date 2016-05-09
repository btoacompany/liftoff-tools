require 'Mongolib.rb'

class ProductSpecs
  Mongolib.connect
  @@collection = "product_specs"

  def find(params = {})
    Mongolib.find(@@collection, params)
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
    params = {
      :product_id => params[:product_id],
      :item_code => params[:item_code],
      :specs => params[:specs],
      :update_time => t,
      :delete_flag => 0
    }

    Mongolib.update(@@collection, {:product_id => params[:product_id]}, params)
  end

  def delete
    params = { :delete_flag => 1 }
    Mongolib.save(@@collection, params)
  end

  def set_time
    return Time.now.strftime("%Y-%m-%d %H:%M:%S")
  end
end
