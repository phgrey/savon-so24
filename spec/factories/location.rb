# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    country 'NO'
    city 'Stockholm'
    pcode '6522771'
    address 'Address line, 1'
    address2 'Address line 2'
  end
end
