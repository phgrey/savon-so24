class Line < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  attr_accessible :count, :name, :price
end
