class Product < ActiveRecord::Base
  attr_accessible :code, :external_id, :name, :price
end
