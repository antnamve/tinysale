require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:user) { create(:user) }

  before sign_in user

  describe "GET index" do
    it 'succeeds' do
      get products_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Get new' do

  end

  describe 'Post create' do

  end
end
