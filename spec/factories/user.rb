# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test moFu'
    email 'phgrey+fgt@gmail.com'
    phone '111-22-33'
    company
    locations {[FactoryGirl.create(:location)]}
  end
end
