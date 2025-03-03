FactoryBot.define do
  factory :favorite do
    associatio :user
    associatio :event
  end
end
