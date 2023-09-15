class OrdersController < ApplicationController
  before_action :load_dishes, only: [:index, :create]
  before_action :initialize_order, only: [:create]
  
  def index
    @order = Order.new # Создаем новый заказ для формы
  end

  def create
    order_items_params = params[:order][:order_items_attributes]
  
    if order_items_params.present?
      order_data = @order.build_order_data(order_items_params)
      @order.order_data = order_data.to_json if order_data.present?
    end
  
    if save_order_and_redirect_to_index
      redirect_to orders_path, notice: 'Заказ успешно создан!'
    else
      render :index
    end
  end  

  def crm
    sorted_dish_counts = Order.dish_counts
    render json: sorted_dish_counts
  end

  private 

  def load_dishes
    @dishes = Dish.all.includes(:ingredients)
  end

  def initialize_order
    @order = Order.new
  end

  def save_order_and_redirect_to_index
    if @order.save
      true
    else
      false
    end
  end
end
