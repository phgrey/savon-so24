# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line do
    product {Product.all.sample}
    count {(1..10).to_a.sample}
    price {product.price}
    name {product.name}
  end
end
