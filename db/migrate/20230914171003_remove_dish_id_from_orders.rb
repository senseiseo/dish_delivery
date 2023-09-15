class RemoveDishIdFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :dish_id
  end
end
