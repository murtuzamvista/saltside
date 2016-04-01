require 'rails_helper'

RSpec.describe BirdsController, type: :controller do

  describe 'GET #index' do
    it 'should respond with 200' do
      get :index
      expect(response.status).to eq 200
    end
  end
end
