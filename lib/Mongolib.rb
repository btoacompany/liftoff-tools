require 'mongo'

class Mongolib
  def self.connect
    @host = "localhost:27017"
    @db = "liftoff_dev" 
    @mongo = Mongo::Client.new([@host ],:database => @db)
  end

  def self.find( collection, cond = {} )
    return @mongo[collection].find(cond)
  end

  def self.distinct( collection, key )
    return @mongo[collection].find.distinct(key)
  end
end
