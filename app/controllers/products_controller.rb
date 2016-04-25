#coding:utf-8

class ProductsController < ApplicationController
  def index
    @products = Products.where(:delete_flag => 0)
  end

  def create
  end

  def create_complete
  end

  def edit
  end
  
  def edit_complete
  end

  def delete
  end
end
