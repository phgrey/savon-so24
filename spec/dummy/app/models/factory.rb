#TODO:move this to spec/support/ (maybe)
class Factory
  extend FactoryGirl::Syntax::Methods

  class << self
    def reload
      FactoryGirl.reload
    end

    def company_ordered
      client = Factory.create :company
      client.users.each do |user|
        (2..5).to_a.sample.times do
          order = Factory.create :order
          user.orders << order
          user.travellers << order.travellers
        end
      end
      client
    end
  end

end
