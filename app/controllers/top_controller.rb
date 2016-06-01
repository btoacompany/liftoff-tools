#coding:utf-8

class TopController < ApplicationController
  before_filter :init
  def init 
    c = Category.new
    @main_category = c.get_main_category
    @categories = c.get_categories
  end

  def index
  end
end
