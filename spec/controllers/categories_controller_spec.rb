require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      post :create, params: { category: {name:'laptop'}}
      expect(Category.count).to eql(1)
    end

    it "returns http success" do
      post :create, params: { category: {name:'laptop'}}
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #index" do
    it "populates an array of categories" do
      get :index, params: { category: {name:'laptop'}}
      expect(assigns(:categories))
    end

     it "renders the :index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
