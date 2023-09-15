class DropOrderDishes < ActiveRecord::Migration[7.0]
  def up
    drop_table :order_dishes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
