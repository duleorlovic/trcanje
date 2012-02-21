FactoryGirl.define do
  factory :users do
    sequence(:name) { |n| "Person #{n}"}
    sequence(:email) { |n| "persion_#{n}@example.com"}
    password "foobar"

    factory :admin do
      admin true
    end
  end
end

FactoryGirl.define do
  factory :micropost do
    content "cao svi"
  end
end
