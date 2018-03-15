require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { create(:project) }

  before do
    create(:subscription)
    create(:external_subscription)
  end

  it { expect(Subscription.count).not_to eq(0) }
  it { expect(ExternalSubscription.count).not_to eq(0) }
  it { expect(Investor.count).not_to eq(0) }

  describe '#investors' do
    context 'when it has no subscription and no external_subscription' do
      it { expect(subject.subscriptions.count).to eq(0) }
      it { expect(subject.external_subscriptions.count).to eq(0) }
      it { expect(subject.investors.count).to eq(0) }
    end

    context 'when it has only subscriptions' do
      let!(:subscription_1) { create(:subscription, project: subject) }
      let!(:subscription_2) { create(:subscription, project: subject) }
      let(:expected_investor_ids) do
        [subscription_1.investor_id, subscription_2.investor_id]
      end

      it { expect(subject.subscriptions.count).to eq(2) }
      it { expect(subject.external_subscriptions.count).to eq(0) }
      it { expect(subject.investors.count).to eq(2) }
      it { expect(subject.investors.pluck(:investor_id).sort.uniq).to eq(expected_investor_ids.sort.uniq) }
    end

    context 'when it has only external_subscriptions' do
      let!(:external_subscription_1) { create(:external_subscription, project: subject) }
      let!(:external_subscription_2) { create(:external_subscription, project: subject) }
      let(:expected_investor_ids) do
        [external_subscription_1.investor_id, external_subscription_2.investor_id]
      end

      it { expect(subject.subscriptions.count).to eq(0) }
      it { expect(subject.external_subscriptions.count).to eq(2) }
      it { expect(subject.investors.count).to eq(2) }
      it { expect(subject.investors.pluck(:investor_id).sort.uniq).to eq(expected_investor_ids.sort.uniq) }
    end

    context 'when it has subscriptions and external_subscriptions' do
      let!(:subscription_1) { create(:subscription, project: subject) }
      let!(:subscription_2) { create(:subscription, project: subject) }
      let!(:external_subscription_1) { create(:external_subscription, project: subject) }
      let!(:external_subscription_2) { create(:external_subscription, project: subject) }
      let(:expected_investor_ids) do
        [
          subscription_1.investor_id, subscription_2.investor_id,
          external_subscription_1.investor_id, external_subscription_2.investor_id
        ]
      end

      it { expect(subject.subscriptions.count).to eq(2) }
      it { expect(subject.external_subscriptions.count).to eq(2) }
      it { expect(subject.investors.count).to eq(4) }
      it { expect(subject.investors.pluck(:investor_id).sort.uniq).to eq(expected_investor_ids.sort.uniq) }

      context 'when an investor has both a subscription and an external_subscription' do
        let(:investor) { create(:investor) }
        let!(:subscription_3) { create(:subscription, project: subject, investor: investor) }
        let!(:external_subscription_3) { create(:external_subscription, project: subject, investor: investor) }
        let(:expected_investor_ids) do
          [
            subscription_1.investor_id, subscription_2.investor_id,
            external_subscription_1.investor_id, external_subscription_2.investor_id,
            investor.id
          ]
        end

        it { expect(subject.subscriptions.count).to eq(3) }
        it { expect(subject.external_subscriptions.count).to eq(3) }
        it { expect(subject.investors.count).to eq(5) }
        it { expect(subject.investors.pluck(:investor_id).sort.uniq).to eq(expected_investor_ids.sort.uniq) }
      end
    end
  end
end
