require 'Mongolib.rb'

class TestsMongo 
  Mongolib.connect
  @@collection = "test_tbl"

  def find(params = {})
    Mongolib.find(@@collection, params)
  end

  def save(params = {})
    t = set_time
    params = {
      :firstname => params[:firstname],
      :lastname => params[:lastname],
      :hobbies => params[:hobbies]
    }
    Mongolib.save(@@collection, params)
  end

  def update(params = {})
    t = set_time
    firstname = params[:firstname]
    params = {
      :item => params[:firstname], 
      :lastname => params[:lastname] 
    }

    Mongolib.update(@@collection, {:firstname => firstname}, params)
  end

  def set_time
    return Time.now.strftime("%Y-%m-%d %H:%M:%S")
  end
end
