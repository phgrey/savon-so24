class Company < ActiveRecord::Base
  attr_accessible :external_id, :title
  has_many :users
  has_many :locations, through: :users

  so24 :company

  def export
    location = locations.first
    remote.class.create({
      id: external_id, #here we can choose between create and update (FUCK YOU)
      consumer_pers_no: id,
      external_no: id,
      is_company: 0, #corporate or private user
      name: title,
      addresses:{address:[location.for_so24, location.for_so24('Visit')]},
      phone_numbers:{phone_number: users.map{|u|{value:u.phone, type:'Primary'}}},
      country: location.country,
      comment: '',
      supplier: false,
      invoice_method:'Email',
      invoice_email: users.first.email,
      status:0
      #relation_data: {},
    })
  end
end
