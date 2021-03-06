class User < ActiveRecord::Base
  belongs_to :company
  has_many :locations

  attr_accessible :email, :external_id, :name, :phone

  so24 name: :person, autoremote:true

  def export
    location = locations.first
    company.external_id = company.export if company.external_id.to_i == 0
    remote.class.create({
      consumer_person_no: id,
      id: external_id.to_i,
      first_name: name,
      last_name: '',
      post_address: location.for_so24('Post'),
      phone_numbers:{phone_number: {value:phone, type:'Primary'}},
      email_addresses:{email_address:{value:email, type:'Primary'}},
      country: location.country,
      relation_data:{relation_data:{
        customer_id: company.external_id,
        title: name,
        email: email,
        phone: phone,
        mobile: phone
      }}
    })
  end
end
