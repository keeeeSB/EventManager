FactoryBot.define do
  factory :participation do
    association :user
    association :event
  end
end
