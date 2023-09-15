require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "GET #index" do
    it "assigns all dishes to @dishes" do
      dish = Dish.create(name: 'dish')
      get :index

      expect(assigns(:dishes)).to eq([dish])
    end

    it "assigns a new order to @order" do
      get :index

      expect(assigns(:order)).to be_a_new(Order)
    end

    it "renders the index template" do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new order" do
        dish = Dish.create(name: "dish")
        ingredient = Ingredient.new(name: "Соль")
        order_params = {
          order: {
            order_items_attributes: [
              { dish_id: dish.id, ingredient_id: ingredient.id, included: '1' },
              { dish_id: dish.id, ingredient_id: ingredient.id },
              { dish_id: dish.id, ingredient_id: ingredient.id }
            ]
          }
        }
    
        expect {
          post :create, params: order_params
        }.to change(Order, :count).by(1)
      end
    end
  end

  describe "GET #crm" do
    it "returns a JSON response with sorted dish counts" do
      dish1 = Dish.create(name: "Dish 1")
      dish2 = Dish.create(name: "Dish 2")
      dish3 = Dish.create(name: "Dish 3")
      Order.create(order_data: '[{"dish_id": ' + dish1.id.to_s + '}, {"dish_id": ' + dish2.id.to_s + '}]')
      Order.create(order_data: '[{"dish_id": ' + dish2.id.to_s + '}, {"dish_id": ' + dish3.id.to_s + '}]')

      get :crm

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:success)
      
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq([{"name"=>"Dish 2", "count"=>2},
                                     {"name"=>"Dish 1", "count"=>1},
                                     {"name"=>"Dish 3", "count"=>1}])
    end
  end
end
