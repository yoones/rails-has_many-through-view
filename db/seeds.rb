3.times do |i|
  Project.create(name: "Project #{i}")
  Investor.create(name: "Investor #{i}")
end

project = Project.find(1)
investor = Investor.find(1)
external_investor = Investor.find(2)

Subscription.create(project: project, investor: investor)
ExternalSubscription.create(project: project, investor: external_investor)

Subscription.create(project: Project.find(2), investor: investor)
