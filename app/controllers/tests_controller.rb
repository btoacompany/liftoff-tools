require 'Util.rb'
require 'Mongolib.rb'

class TestsController < ApplicationController
  def index
    main_category = Util.main_category

    @tests = Makers.where(:id => 1)

    Mongolib.connect
    @tests1 = Mongolib.find(:test_tbl, {:firstname => "john"})
    @tests2 = Mongolib.find(:test_tbl)
  end
end
