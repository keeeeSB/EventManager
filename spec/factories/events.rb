FactoryBot.define do
  factory :event do
    title { "映画鑑賞会" }
    description { "映画鑑賞をしましょう！" }
    start_time { "2025-10-10" }
    location { "各家庭" }
    association :user
    association :category
  end
end
