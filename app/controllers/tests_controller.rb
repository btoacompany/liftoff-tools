require 'Util.rb'

class TestsController < ApplicationController
  def index
    main_category = Util.main_category

    @tests = Makers.where(:id => 1)

    specs = ProductSpecs.new
    @tests1 = specs.find({:firstname => "john"})
  end
end
