class Order < ActiveRecord::Base
  belongs_to :user
  has_many :lines
  attr_accessible :comment, :external_id, :number

  so24 :invoice

  def export
    self.class.remote.create({

    })
  end
end
