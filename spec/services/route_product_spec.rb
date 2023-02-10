require 'rails_helper'

RSpec.describe RouteProduct do
  let(:product) { create(:product, category: 'cat1', reference: 'ref2', price: 100) }

  describe '#call' do
    subject { described_class.new(product).call }

    context 'when routes has categories set only' do
      let!(:destination) { create(:destination, categories: ['cat1', 'cat2']) }
      let!(:destination_1) { create(:destination, categories: ['cat2']) }
      let!(:destination_2) { create(:destination, maximum_price: 101) }

      it 'assign route successfully' do
        subject

        expect(product.reload.destination_id).to eq(destination.id)
      end
    end

    context 'when routes has references set only' do
      let!(:destination) { create(:destination, references: ['ref1', 'ref2']) }
      let!(:destination_1) { create(:destination, references: ['ref2']) }
      let!(:destination_2) { create(:destination, maximum_price: 101) }

      it 'assign route successfully' do
        subject

        expect(product.reload.destination_id).to eq(destination.id)
      end
    end

    context 'when routes has both categories & references set' do
      let!(:destination) { create(:destination, references: ['ref1', 'ref2'], categories: ['cat1', 'cat2']) }
      let!(:destination_1) { create(:destination, references: ['ref2']) }
      let!(:destination_2) { create(:destination, categories: ['cat2']) }
      let!(:destination_3) { create(:destination, maximum_price: 101) }
      let!(:destination_4) { create(:destination, references: ['ref2'], categories: ['cat1']) }

      it 'assign route successfully' do
        subject

        expect(product.reload.destination_id).to eq(destination.id)
      end
    end
  end
end
