require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe 'GET index' do
    let!(:product) { create(:product, category: 'Cat1', reference: 'Ref1') }

    before { get '/products' }

    it 'return success' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(assigns(:products)).to match_array([product])
    end
  end

  describe 'GET new' do
    before { get '/products/new' }

    it 'return success' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
      expect(assigns(:product).id).to be_nil
    end
  end

  describe 'POST create' do
    let(:params) do
      {
        product: {
          name: 'D1',
          category: 'Cat1',
          reference: 'Ref1',
          price: 100
        }
      }
    end

    before { post '/products', params: params }

    it 'return success' do
      created_record = assigns(:product)

      expect(created_record.name).to eq('D1')
      expect(created_record.category).to eq('Cat1')
      expect(created_record.reference).to eq('Ref1')
      expect(created_record.price).to eq(100)

      expect(response).to redirect_to(products_path)
    end

    context 'when invalid params' do
      let(:params) do
        {
          product: {
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
    let!(:product) { create(:product, id: 1, category: 'Cat1', reference: 'Ref1') }
    before { get '/products/1' }

    it 'return success' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(assigns(:product).id).to eq(1)
    end
  end

  describe 'GET edit' do
    let!(:product) { create(:product, id: 1, category: 'Cat1', reference: 'Ref1') }
    before { get '/products/1/edit' }

    it 'return success' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
      expect(assigns(:product).id).to eq(1)
    end
  end

  describe 'PUT update' do
    let(:params) do
      {
        product: {
          name: 'D1',
          category: 'Cat1',
          reference: 'Ref1',
          price: 100
        }
      }
    end

    let!(:product) { create(:product, id: 1, category: 'Cat', reference: 'Ref') }

    before { put '/products/1', params: params }

    it 'return success' do
      created_record = assigns(:product)

      expect(created_record.name).to eq('D1')
      expect(created_record.category).to eq('Cat1')
      expect(created_record.reference).to eq('Ref1')
      expect(created_record.price).to eq(100)

      expect(response).to redirect_to(product_path(1))
    end

    context 'when invalid params' do
      let(:params) do
        {
          product: {
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
    let!(:product) { create(:product, id: 1, category: 'Cat', reference: 'Ref') }

    before { delete '/products/1' }

    it 'return success' do
      expect(response).to redirect_to(products_path)
      expect { product.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
