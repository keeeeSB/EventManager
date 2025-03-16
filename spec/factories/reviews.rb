FactoryBot.define do
  factory :review do
    body { "とてもよかったです。" }
    rating { "5" }
    association :user
    association :event
  end
end
