# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    title "MyString"
    author "MyString"
    description "MyText"
    image "MyString"
  end
end
