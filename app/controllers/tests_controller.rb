class TestsController < ApplicationController
  def index
    test = TestsMongo.new
    @tests = [] 
    params = {
      :firstname => "elvis",
      :lastname => "man"
    }

    #test.update(params)

    if params.present?
      logger.debug "------"
      logger.debug params["chk"]
    end
  end
end
