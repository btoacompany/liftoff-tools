require 'mongo'

class Mongolib
  def self.connect
    @host = "localhost:27017"
    @db = "liftoff_dev" 
    @mongo = Mongo::Client.new([@host ],:database => @db)
  end

  def self.find( collection, cond = {} )
    @mongo[collection].find(cond)
  end

  def self.distinct( collection, field, cond = {})
    @mongo[collection].find(cond).distinct(field)
  end

  def self.save( collection, cond = {} )
    @mongo[collection].insert_one(cond)
  end

  def self.update( collection, cond = {}, params = {} )
    @mongo[collection].find(cond).update_many({'$set' => params})
  end
end
