require 'rails_helper'

RSpec.describe 'Destinations', type: :request do
  describe 'GET routed_products' do
    let!(:destination) { create(:destination) }
    let!(:route_product) { create(:product, destination: destination, reference: 'ref1', category: 'cat1') }
    let!(:unrouted_product) { create(:product, reference: 'ref', category: 'cat') }

    before { get '/destinations/routed_products' }

    it 'return success' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:routed_products)
      expect(assigns(:routed_products)).to match_array([route_product])
      expect(assigns(:unrouted_products)).to match_array([unrouted_product])
    end
  end

  describe 'POST assign_route' do
    let!(:product) { create(:product, category: 'Cat1', reference: 'Ref1') }
    let!(:destination) { create(:destination, categories: ['Cat1'], references: ['Ref1']) }

    before { post '/destinations/assign_route', params: { product_id: product.id } }

    it 'assign to route destination' do
      expect(product.reload.destination_id).to eq(destination.id)
      expect(response).to redirect_to(routed_products_destinations_path)
    end
  end

  describe 'GET index' do
    let!(:destination) { create(:destination, categories: ['Cat1'], references: ['Ref1']) }

    before { get '/destinations' }

    it 'return success' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(assigns(:destinations)).to match_array([destination])
    end
  end

  describe 'GET new' do
    before { get '/destinations/new' }

    it 'return success' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
      expect(assigns(:destination).id).to be_nil
    end
  end

  describe 'POST create' do
    let(:params) do
      {
        destination: {
          name: 'D1',
          categories: ['Cat1'],
          references: ['Ref1'],
          maximum_price: 100
        }
      }
    end

    before { post '/destinations', params: params }

    it 'return success' do
      created_record = assigns(:destination)

      expect(created_record.name).to eq('D1')
      expect(created_record.categories).to eq(['Cat1'])
      expect(created_record.references).to eq(['Ref1'])
      expect(created_record.maximum_price).to eq(100)

      expect(response).to redirect_to(destinations_path)
    end

    context 'when invalid params' do
      let(:params) do
        {
          destination: {
            name: ''
          }
        }
      end

      it 'render form' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET show' do
    let!(:destination) { create(:destination, id: 1, categories: ['Cat1'], references: ['Ref1']) }
    before { get '/destinations/1' }

    it 'return success' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(assigns(:destination).id).to eq(1)
    end
  end

  describe 'GET edit' do
    let!(:destination) { create(:destination, id: 1, categories: ['Cat1'], references: ['Ref1']) }
    before { get '/destinations/1/edit' }

    it 'return success' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
      expect(assigns(:destination).id).to eq(1)
    end
  end

  describe 'PUT update' do
    let(:params) do
      {
        destination: {
          name: 'D1',
          categories: ['Cat1'],
          references: ['Ref1'],
          maximum_price: 100
        }
      }
    end

    let!(:destination) { create(:destination, id: 1, categories: ['Cat'], references: ['Ref']) }

    before { put '/destinations/1', params: params }

    it 'return success' do
      updated_record = assigns(:destination)

      expect(updated_record.name).to eq('D1')
      expect(updated_record.categories).to eq(['Cat1'])
      expect(updated_record.references).to eq(['Ref1'])
      expect(updated_record.maximum_price).to eq(100)
      expect(response).to redirect_to(destination_path(1))
    end

    context 'when invalid params' do
      let(:params) do
        {
          destination: {
            name: ''
          }
        }
      end

      it 'render form' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:destination) { create(:destination, id: 1, categories: ['Cat'], references: ['Ref']) }

    before { delete '/destinations/1' }

    it 'return success' do
      expect(response).to redirect_to(destinations_path)
      expect { destination.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
