class Investor < ApplicationRecord
  has_many :subscriptions
  has_many :external_subscriptions
  has_many :project_investors
  has_many :projects, through: :project_investors
end
