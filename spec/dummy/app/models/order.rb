class Order < ActiveRecord::Base
  belongs_to :user
  attr_accessible :comment, :external_id, :number
end
