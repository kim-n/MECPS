FactoryGirl.define do
  factory :user do
    email 'user@email.com'
    name 'Name Surname'
    password 'password'
    
    factory :incomplete_user do
      email ''
      name ''
      password ''
      session_token ''
    end
    
    factory :admin do
      admin 1
    end
  end

end