class User < ActiveRecord::Base
  belongs_to :company
  attr_accessible :email, :external_id, :name
end
