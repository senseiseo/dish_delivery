class AddOrderDataToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :order_data, :jsonb
  end
end
