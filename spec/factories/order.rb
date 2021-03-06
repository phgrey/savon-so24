# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    lines {(2..4).to_a.sample.times.map{ FactoryGirl.create(:line)}}
    user
    delivery_location {FactoryGirl.create(:location)}
    invoice_location {FactoryGirl.create(:location)}
  end
end
