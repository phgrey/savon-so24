class Location < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :address2, :city, :country, :name, :pcode, :phone, :type

  def for_so24 type='Delivery'
    {
        type: type,
        #name: 'Test fake name',
        street: address,
        postal_code: pcode,
        #postal_area: '',
        city: city,
        #county: '',
        #state: '',
        description: 'test location',
        country: country,
    }
  end
end
