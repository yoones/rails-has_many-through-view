FactoryBot.define do
  factory :investor do
    sequence(:name) { |n| "Investor #{n}" }
  end
end
