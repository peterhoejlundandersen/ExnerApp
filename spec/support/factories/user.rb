FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "badass#{n}@damm.dk"}
    password "badass"
    password_confirmation "badass"
  end
end
